variable "region" {
  type        = string
  description = "The region to use for the S3 bucket"
  default     = "us-west-2"
}

variable "bucket_prefix" {
  type        = string
  description = "The prefix to use for the S3 bucket"
  default     = "tf-s3-website-demo"
}

resource "aws_s3_bucket" "bucket" {
  bucket_prefix = var.bucket_prefix
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.bucket.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PublicReadGetObject",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:GetObject",
      "Resource": "arn:aws:s3:::${aws_s3_bucket.bucket.id}/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.bucket.id
  index_document {
    suffix = "index.html"
  }
  error_document{
    key = "error.html"
  }
}

module "template_files" {
  source = "hashicorp/dir/template"

  base_dir = "${path.module}frontend/public"
}

resource "aws_s3_bucket_object" "object" {
  for_each = module.template_files.files

  bucket       = aws_s3_bucket.bucket.id
  key          = each.key
  content_type = each.value.content_type

  # The template_files module guarantees that only one of these two attributes
  # will be set for each file, depending on whether it is an in-memory template
  # rendering result or a static file on disk.
  source  = each.value.source_path
  content = each.value.content
}

output "bucket_website_endpoint" {
  value = aws_s3_bucket.bucket.website_endpoint
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.bucket.arn
}

output "s3_bucket_id" {
  value = aws_s3_bucket.bucket.id
}
