resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    Environment = "test"
    UserUuid = "var.user_uuid"
  }
}

