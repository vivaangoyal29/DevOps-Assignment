data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "demo" {
  bucket = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}"
    Environment = "dev"
    ManagedBy   = "Terraform"
    Project     = "Session18-Terraform-S3-Demo"
  }
}

resource "aws_s3_bucket_public_access_block" "demo" {
  bucket                  = aws_s3_bucket.demo.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "demo" {
  bucket = aws_s3_bucket.demo.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
