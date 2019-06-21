# VPCとインターネット間をつなぐ
resource "aws_internet_gateway" "ex" {
  vpc_id = aws_vpc.ex.id
  tags = {
      Name = "ex"
  }
}

# NATゲートウェイ
resource "aws_nat_gateway" "ex" {
  subnet_id = aws_subnet.public.id  # プライベートでなくパブリックな方に配置
  depends_on = [aws_internet_gateway.ex]
  allocation_id = aws_eip.nat_gateway.id    # Elastic IP Address
  tags = {
      Name = "nat_ex"
  }
}
