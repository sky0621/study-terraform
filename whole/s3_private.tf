resource "aws_s3_bucket" "private_bucket" {
  bucket = "private-sky0621-tf-on-aws"

  versioning {
      enabled = true
  }

  server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
          }
      }
  }
}
