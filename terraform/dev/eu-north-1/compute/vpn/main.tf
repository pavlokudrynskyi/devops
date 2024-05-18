module "pritunl_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "pritunl"
  description = "Security group for pritunl VPN"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["https-443-tcp", "http-80-tcp"]
  egress_cidr_blocks  = ["0.0.0.0/0"]
  egress_rules        = ["all-all"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 10564
      to_port     = 10564
      protocol    = "udp"
      description = "VPN Port"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "all-all"
      description = "Local VPC"
      cidr_blocks = data.terraform_remote_state.vpc.outputs.vpc_cidr_block
    },
  ]
}

module "pritunl" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"

  name = "pritunl"

  ami                    = var.ami_id
  instance_type          = "t3.medium"
  monitoring             = false
  source_dest_check      = false
  key_name               = "pritunl"
  iam_instance_profile   = data.terraform_remote_state.ssm.outputs.iam_instance_profile_id
  vpc_security_group_ids = [module.pritunl_sg.security_group_id]
  subnet_id              = data.terraform_remote_state.vpc.outputs.public_subnets[0]

  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      volume_size = 40
    },
  ]

  tags = var.tags
}
