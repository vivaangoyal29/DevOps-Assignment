variable "aws_region" {
  type        = string
  description = "AWS region where the S3 bucket will be created."
  default     = "ap-south-1"
}

variable "bucket_name_prefix" {
  type        = string
  description = "Lowercase S3 bucket name prefix; the AWS account ID is appended for global uniqueness."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{2,30}[a-z0-9]$", var.bucket_name_prefix))
    error_message = "Use 4-32 lowercase letters, numbers, or hyphens; start and end with a letter or number."
  }
}
