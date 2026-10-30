variable "aws_region" {
  description = "AWS region for the Session 19 infrastructure demo."
  type        = string
  default     = "ap-south-1"
}

variable "instance_type" {
  description = "EC2 instance type for the demo web server."
  type        = string
  default     = "t3.micro"
}

variable "bucket_name_prefix" {
  description = "Lowercase S3 bucket prefix. The AWS account ID is appended to make the name unique."
  type        = string
  default     = "devops-heros-session19"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{2,30}[a-z0-9]$", var.bucket_name_prefix))
    error_message = "Use 4-32 lowercase letters, numbers, or hyphens; start and end with a letter or number."
  }
}
