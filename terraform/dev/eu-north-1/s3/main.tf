module "infrastructure" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.1"

  bucket = "theprojectname-tfstates-dev"

  block_public_acls       = true
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_policy     = true
  tags   = var.tags
  server_side_encryption_configuration = {
    rule = {
      apply_server_side_encryption_by_default = {
         sse_algorithm = "AES256"
      }
    }
  }
  versioning = {
    enabled = true
  }
}