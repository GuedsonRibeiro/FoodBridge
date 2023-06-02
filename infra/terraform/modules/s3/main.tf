# A basic S3 module - please modify to your needs

resource "aws_s3_bucket" "b" {
  bucket = "bucket-name"
  acl    = "private"
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.b.arn
}
