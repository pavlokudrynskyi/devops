resource "aws_guardduty_detector" "MyDetector" {
  enable = true

  datasources {
    s3_logs {
      enable = true
    }
    kubernetes {
      audit_logs {
        enable = true
      }
    }
    ebs_volumes {
      enable = true
    }
  }
}

module "securityhub" {
  source = "cloudposse/security-hub/aws"
  version = "0.12.1"

  create_sns_topic = true
  subscribers = {
    opsgenie = {
      protocol               = "https"
      endpoint               = "https://api.theprojectname.com/v1/"
      endpoint_auto_confirms = true
      raw_message_delivery   = false
    }
  }
}