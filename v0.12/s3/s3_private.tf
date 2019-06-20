resource "aws_s3_bucket" "private_bucket" {
  bucket = "private-sky0621-tf-on-aws"  # バケット名は全世界でユニークである必要がある

  versioning {
      enabled = true    # オブジェクトを変更・削除しても元に戻せる
  }

  server_side_encryption_configuration {
      rule {
          apply_server_side_encryption_by_default {
              sse_algorithm = "AES256"
          }
      }
  }
}

# 予期しないオブジェクトの公開を抑止
resource "aws_s3_bucket_public_access_block" "private" {
  bucket = aws_s3_bucket.private_bucket.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
