# ルーティング情報を管理するルートテーブル
# local(ローカルルート)が自動的に作成される
# デフォルトルートはひとつのルートテーブルにつき、ひとつ

# https://www.terraform.io/docs/providers/aws/r/route_table.html

# パブリック用
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ex.id
  tags = {
      Name = "public"
  }
}

# プライベート用
# ルートテーブルもアベイラビリティゾーンごとに作成
resource "aws_route_table" "private_0" {
  vpc_id = aws_vpc.ex.id
  tags = {
      Name = "private_0"
  }
}

resource "aws_route_table" "private_1" {
  vpc_id = aws_vpc.ex.id
  tags = {
      Name = "private_1"
  }
}

# https://www.terraform.io/docs/providers/aws/r/route.html

# ルートテーブルの１レコード（パブリック用）
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id    # ルートテーブルと紐付け
  gateway_id = aws_internet_gateway.ex.id   # インターネットゲートウェイと紐付け
  destination_cidr_block = "0.0.0.0/0"  # デフォルトルート
}

# ルートテーブルの１レコード（プライベート用）
resource "aws_route" "private_0" {
  route_table_id = aws_route_table.private_0.id   # ルートテーブルと紐付け
  nat_gateway_id = aws_nat_gateway.ex_0.id    # NATゲートウェイと紐付け
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "private_1" {
  route_table_id = aws_route_table.private_1.id   # ルートテーブルと紐付け
  nat_gateway_id = aws_nat_gateway.ex_1.id    # NATゲートウェイと紐付け
  destination_cidr_block = "0.0.0.0/0"
}

# https://www.terraform.io/docs/providers/aws/r/route_table_association.html

# どのルートテーブルを使うかはサブネット単位で判断
# ※この紐付けなしの場合はデフォルトルートテーブルが使われる
# パブリック用
resource "aws_route_table_association" "public_0" {
  subnet_id = aws_subnet.public_0.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1" {
  subnet_id = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

# プライベート用
resource "aws_route_table_association" "private_0" {
  subnet_id = aws_subnet.private_0.id
  route_table_id = aws_route_table.private_0.id
}

resource "aws_route_table_association" "private_1" {
  subnet_id = aws_subnet.private_1.id
  route_table_id = aws_route_table.private_1.id
}
