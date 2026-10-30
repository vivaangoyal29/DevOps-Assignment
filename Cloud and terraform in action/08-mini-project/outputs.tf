output "vpc_id" {
  description = "ID of the demo VPC."
  value       = aws_vpc.main.id
}

output "vpc_cidr" {
  description = "CIDR block of the demo VPC."
  value       = aws_vpc.main.cidr_block
}

output "subnet_id" {
  description = "ID of the public subnet."
  value       = aws_subnet.public.id
}

output "security_group_id" {
  description = "ID of the web server security group."
  value       = aws_security_group.web.id
}

output "instance_id" {
  description = "ID of the EC2 web server."
  value       = aws_instance.web.id
}

output "instance_public_ip" {
  description = "Public IPv4 address of the EC2 web server."
  value       = aws_instance.web.public_ip
}

output "website_url" {
  description = "HTTP URL for the demo web server. The page may take a few minutes to become available."
  value       = "http://${aws_instance.web.public_dns}"
}

output "bucket_name" {
  description = "Name of the private S3 demo bucket."
  value       = aws_s3_bucket.demo.bucket
}

output "bucket_arn" {
  description = "ARN of the private S3 demo bucket."
  value       = aws_s3_bucket.demo.arn
}
