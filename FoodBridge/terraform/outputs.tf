output "ec2_public_ip" {
  description = "Public IP of EC2 instance"
  value       = module.ec2.ec2_public_ip
}

output "rds_endpoint" {
  description = "Endpoint of RDS instance"
  value       = module.rds.rds_endpoint
}

output "s3_bucket_arn" {
  description = "ARN of S3 bucket"
  value       = module.s3.s3_bucket_arn
}
