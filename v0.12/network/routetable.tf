# ルーティング情報を管理するルートテーブル
# local(ローカルルート)が自動的に作成される
# パブリック用
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.ex.id
}

# プライベート用
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.ex.id
}

# ルートテーブルの１レコード（パブリック用）
resource "aws_route" "public" {
  route_table_id = aws_route_table.public.id    # ルートテーブルと紐付け
  gateway_id = aws_internet_gateway.ex.id   # インターネットゲートウェイと紐付け
  destination_cidr_block = "0.0.0.0/0"  # デフォルトルート
}

# ルートテーブルの１レコード（プライベート用）
resource "aws_route" "private" {
  route_table_id = aws_route_table.private.id   # ルートテーブルと紐付け
  nat_gateway_id = aws_nat_gateway.ex.id    # NATゲートウェイと紐付け
  destination_cidr_block = "0.0.0.0/0"
}

# どのルートテーブルを使うかはサブネット単位で判断
# ※この紐付けなしの場合はデフォルトルートテーブルが使われる
# パブリック用
resource "aws_route_table_association" "public" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# プライベート用
resource "aws_route_table_association" "private" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
