# 信頼ポリシー
data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
      actions = ["sts:AssumeRole"]  # STS(Security Token Service): 役割(role)を引き受ける(assume)

      principals {
          type = "Service"
          identifiers = ["ec2.amazonaws.com"]   # このポリシーがアタッチされたIAMロールはEC2のみ利用可能
      }
  }
}

# IAMロール
resource "aws_iam_role" "ex" {
  name = "ex"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json    # 「AssumeRoleはRoleArnを入力するとCredentialsを返すAPIだ」
}

resource "aws_iam_policy" "ex" {
  name = "ex"
  policy = data.aws_iam_policy_document.ec2_assume_role.json
}

# IAMロールにIAMポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "ex" {
  role = aws_iam_role.ex.name
  policy_arn = aws_iam_policy.ex.arn
}
