resource "aws_iam_policy" "ex" {
  name = "ex"
  policy = data.aws_iam_policy_document.allow_describe_regions.json
}
