resource "aws_s3_bucket" "alb_log" {
  bucket = "alb-log-sky0621-tf-on-aws"

  lifecycle_rule {
      enabled = true

      expiration {
          days = "180"
      }
  }
}

data "aws_iam_policy_document" "alb_log" {
  statement {
      principals {
          type = "AWS"
          identifiers = ["582318560864"]    # AWSのアカウントID
      }

      resources = ["arn:aws:s3:::${aws_s3_bucket.alb_log.id}/*"]
      actions = ["s3:PutObject"]
      effect = "Allow"
  }
}

resource "aws_s3_bucket_policy" "alb_log" {
  bucket = aws_s3_bucket.alb_log.id
  policy = data.aws_iam_policy_document.alb_log.json
}
