# A basic S3 module - please modify to your needs

resource "aws_s3_bucket" "b" {
  bucket = "bucket-name"
  acl    = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

resource "aws_s3_bucket_object" "object" {
  for_each = fileset("${path.module}/../../frontend/public", "**/*")

  bucket = aws_s3_bucket.b.id
  key    = each.value
  source = "${path.module}/../../frontend/public/${each.value}"
  acl    = "public-read"
  etag   = filemd5("${path.module}/../../frontend/public/${each.value}")
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.b.arn
}

output "s3_bucket_id" {
  value = aws_s3_bucket.b.id
}
