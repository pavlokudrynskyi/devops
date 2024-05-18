resource "aws_iam_policy" "alb" {
  name        = "AWSLoadBalancerControllerIAMPolicy${var.environment}"
  description = "For AWS ALB Controller"
  policy      = file("policies/AWSLoadBalancerControllerIAMPolicy.json")
  tags        = var.iam_tags
}

resource "aws_iam_role" "alb-controller" {
  name        = "AmazonEKSLoadBalancerControllerRole${var.environment}"
  description = "For EKS ALB Controller"
  assume_role_policy = templatefile(
    "policies/AssumeRolePolicy.json.tpl", {
      openid_provider_arn = module.eks.oidc_provider_arn
      openid_sub_string   = module.eks.oidc_provider
  })
  tags = var.iam_tags
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.alb-controller.name
  policy_arn = aws_iam_policy.alb.arn
}

resource "aws_iam_policy" "externaldns" {
  name        = "AllowExternalDNSUpdates${var.environment}"
  description = "Allow External DNS Updates for External DNS"
  policy      = file("policies/AllowExternalDNSUpdatesPolicy.json")
  tags        = var.iam_tags
}

resource "aws_iam_role" "externaldns" {
  name        = "AWSExternalDNSClusterRole${var.environment}"
  description = "External DNS cluster role"
  assume_role_policy = templatefile(
    "policies/ExternalDNSAssumeRolePolicy.json.tpl", {
      openid_provider_arn = module.eks.oidc_provider_arn
      openid_sub_string   = module.eks.oidc_provider
  })
  tags = var.iam_tags
}

resource "aws_iam_role_policy_attachment" "externaldns" {
  role       = aws_iam_role.externaldns.name
  policy_arn = aws_iam_policy.externaldns.arn
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.21.0"

  cluster_name                    = var.cluster_name
  cluster_version                 = var.k8s_version
  subnet_ids                      = data.terraform_remote_state.vpc.outputs.private_subnets
  create_cluster_security_group   = true
  create_iam_role                 = true
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false
  cluster_service_ipv4_cidr       = var.cluster_service_ipv4_cidr
  cluster_security_group_additional_rules = {
    egress_nodes_ephemeral_ports_tcp = {
      description                = "To node 1025-65535"
      protocol                   = "tcp"
      from_port                  = 1025
      to_port                    = 65535
      type                       = "egress"
      source_node_security_group = true
    }
  }
  cluster_addons = {
    vpc-cni = {
      addon_version     = var.vpc_cni_version
      resolve_conflicts = "OVERWRITE"
    }
  }
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }
  vpc_id                   = data.terraform_remote_state.vpc.outputs.vpc_id
  cluster_tags             = { Name = var.cluster_name }
  node_security_group_tags = var.sg_tags
  iam_role_tags            = var.iam_tags
  tags                     = var.eks_tags
  eks_managed_node_groups = {
    for group in keys(var.node_groups) :
    group => {
      desired_size               = lookup(var.node_groups, group, null)["desired_size"]
      max_size                   = lookup(var.node_groups, group, null)["max_size"]
      min_size                   = lookup(var.node_groups, group, null)["min_size"]
      instance_types             = lookup(var.node_groups, group, null)["instance_types"]
      capacity_type              = lookup(var.node_groups, group, null)["capacity_type"]
      disk_size                  = lookup(var.node_groups, group, null)["disk_size"]
      launch_template_tags       = data.aws_default_tags.default.tags
      security_group_tags        = var.sg_tags
      use_name_prefix            = true
      name                       = (group)
      ami_id                     = var.ami_id
      enable_bootstrap_user_data = true
      cluster_endpoint           = module.eks.cluster_endpoint
      cluster_auth_base64        = module.eks.cluster_certificate_authority_data
      block_device_mappings = {
        xvda = {
          device_name = "/dev/xvda"
          ebs = {
            delete_on_termination = true
            encrypted             = false
            volume_size           = lookup(var.node_groups, group, null)["disk_size"]
            volume_type           = lookup(var.node_groups, group, null)["disk_type"]
          }
        }
      }
      labels = {
        dedicated = (group)
      }
      update_config = {
        max_unavailable_percentage = 50
      }
    }
  }
  manage_aws_auth_configmap = true

  aws_auth_users = [
    {
      userarn  = "arn:aws:iam::533267322387:root"
      username = "admin:root"
      groups   = ["system:masters"]
    },
  ]
}


resource "aws_iam_role_policy_attachment" "ssm" {
  for_each   = { for group, iam_role_name in module.eks.eks_managed_node_groups : group => iam_role_name }
  role       = each.value["iam_role_name"]
  policy_arn = data.terraform_remote_state.ssm.outputs.iam_policy_arn
}

resource "aws_security_group_rule" "vpn_ingress" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = var.ingress_cidr_blocks
  security_group_id = module.eks.cluster_primary_security_group_id
  description       = "VPN ingress rule"
}

resource "aws_security_group_rule" "vpn_ingress_additional" {
  type              = "ingress"
  protocol          = "-1"
  from_port         = 0
  to_port           = 0
  cidr_blocks       = var.ingress_cidr_blocks
  security_group_id = module.eks.cluster_security_group_id
  description       = "VPN ingress rule"
}

resource "aws_security_group_rule" "node_exporter" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9100
  to_port           = 9100
  cidr_blocks       = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks
  security_group_id = module.eks.node_security_group_id
  description       = "Pods to Nodes for Prometheus operator"
}

resource "aws_security_group_rule" "https" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 443
  to_port           = 443
  cidr_blocks       = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks
  security_group_id = module.eks.node_security_group_id
  description       = "https"
}

resource "aws_security_group_rule" "alb" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 9443
  to_port           = 9443
  cidr_blocks       = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks
  security_group_id = module.eks.node_security_group_id
  description       = "alb"
}

resource "aws_security_group_rule" "core_dns_udp" {
  type              = "ingress"
  protocol          = "udp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks
  security_group_id = module.eks.node_security_group_id
  description       = "Pods to Nodes for coredns"
}

resource "aws_security_group_rule" "core_dns_tcp" {
  type              = "ingress"
  protocol          = "tcp"
  from_port         = 53
  to_port           = 53
  cidr_blocks       = data.terraform_remote_state.vpc.outputs.private_subnets_cidr_blocks
  security_group_id = module.eks.node_security_group_id
  description       = "Pods to Nodes for coredns"
}

module "ebs_iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "4.13.2"

  create_role      = true
  role_name        = "aws-infr-role-${lower(var.environment)}-ebs"
  provider_url     = data.terraform_remote_state.eks.outputs.cluster_oidc_issuer_url
  role_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]

  oidc_fully_qualified_subjects = [
    "system:serviceaccount:kube-system:ebs-csi-controller-sa"
  ]
}

## After EKS apply 

resource "kubernetes_namespace" "infra" {
  metadata {
    labels = {
      "argocd.argoproj.io/instance" = "infrastructure"
    }
    name = "infra-tools"
  }
}

resource "kubernetes_service_account" "alb-sa" {
  metadata {
    name      = "aws-load-balancer-controller"
    namespace = kubernetes_namespace.infra.metadata[0].name
    labels = {
      "app.kubernetes.io/component" = "controller",
      "app.kubernetes.io/name"      = "aws-load-balancer-controller"
    }
    annotations = {
      "eks.amazonaws.com/role-arn" = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/AmazonEKSLoadBalancerControllerRoleProduction"
    }
  }
}
