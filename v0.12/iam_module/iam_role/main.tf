# ###################################################################
# Variable
# ###################################################################
variable "name" {}
variable "policy" {}
variable "identifier" {}

# ###################################################################
# Statement
# 指定したリソース(identifier)を操作するCredentialを返せるIAMロールの定義
# ###################################################################
# 権限は「ポリシー」で定義
# 「ポリシー」は「ポリシードキュメント」というJSONで記述
# どのリソースに何ができるかを定義
data "aws_iam_policy_document" "assume_role" {
  statement {
      # sts = Security Token Service
      # AssumeRole = RoleのARN(=Amazon Resource Name)を入力するとCredentialsを返すAPI
      actions = ["sts:AssumeRole"]

      principals {
          type = "Service"
          identifiers = [var.identifier]    # 例："ec2.amazonaws.com"
      }
  }
}

# 「IAMロール」は「ポリシードキュメント」を保持する
resource "aws_iam_role" "default" {
  name = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# ###################################################################
# 指定したポリシー(policy)を保持するIAMポリシーとIAMロールを紐付ける

# 「ポリシードキュメント」を保持するリソースが「IAMポリシー」
resource "aws_iam_policy" "default" {
  name = var.name
  policy = var.policy
}

# 「IAMロール」に「IAMポリシー」をアタッチ
resource "aws_iam_role_policy_attachment" "default" {
  role = aws_iam_role.default.name  # Nameを指定しないといけない。。。
  policy_arn = aws_iam_policy.arn   # ARNを指定しないといけない
}

# ###################################################################
# Output
# ###################################################################
output "iam_role_arn" {
  value = aws_iam_role.default.arn
}

output "iam_role_name" {
  value = aws_iam_role.default.name
}
