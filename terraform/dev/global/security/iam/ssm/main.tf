module "iam_assumable_role" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version = "5.37.2"

  trusted_role_services = [
    "ssm.amazonaws.com",
    "ec2.amazonaws.com"
  ]

  create_role             = true
  create_instance_profile = true

  role_name         = "aws-infr-role-${lower(data.aws_default_tags.default.tags.Environment)}-${lower(data.aws_default_tags.default.tags.Application)}"
  role_requires_mfa = false

  custom_role_policy_arns = [
    module.iam_policy.arn,
  ]
}

module "iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.37.2"

  name        = "aws-infr-policy-${lower(data.aws_default_tags.default.tags.Environment)}-${lower(data.aws_default_tags.default.tags.Application)}"
  description = "Access to S3 Bucket for SSM"
  policy = jsonencode(
    {
      Version : "2012-10-17"
      Statement : [
        {
          Effect : "Allow",
          Action : [
            "ssm:DescribeAssociation",
            "ssm:GetDeployablePatchSnapshotForInstance",
            "ssm:GetDocument",
            "ssm:DescribeDocument",
            "ssm:GetManifest",
            "ssm:GetParameter",
            "ssm:GetParameters",
            "ssm:ListAssociations",
            "ssm:ListInstanceAssociations",
            "ssm:PutInventory",
            "ssm:PutComplianceItems",
            "ssm:PutConfigurePackageResult",
            "ssm:UpdateAssociationStatus",
            "ssm:UpdateInstanceAssociationStatus",
            "ssm:UpdateInstanceInformation"
          ],
          "Resource" : "*"
        },
        {
          Effect : "Allow",
          Action : [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
          ],
          "Resource" : "*"
        },
        {
          Effect : "Allow",
          Action : [
            "ec2messages:AcknowledgeMessage",
            "ec2messages:DeleteMessage",
            "ec2messages:FailMessage",
            "ec2messages:GetEndpoint",
            "ec2messages:GetMessages",
            "ec2messages:SendReply"
          ],
          "Resource" : "*"
        },
      ]
    }
  )
}
