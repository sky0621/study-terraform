# VPCとインターネット間をつなぐ
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html

resource "aws_internet_gateway" "ex" {
  vpc_id = aws_vpc.ex.id
  tags = {
      Name = "ex"
  }
}

# NATゲートウェイ
# https://www.terraform.io/docs/providers/aws/r/nat_gateway.html

resource "aws_nat_gateway" "ex_0" {
  subnet_id = aws_subnet.public_0.id  # プライベートでなくパブリックな方に配置
  depends_on = [aws_internet_gateway.ex]
  allocation_id = aws_eip.nat_gateway_0.id    # Elastic IP Address
  tags = {
      Name = "nat_ex_0"
  }
}

resource "aws_nat_gateway" "ex_1" {
  subnet_id = aws_subnet.public_1.id  # プライベートでなくパブリックな方に配置
  depends_on = [aws_internet_gateway.ex]
  allocation_id = aws_eip.nat_gateway_1.id    # Elastic IP Address
  tags = {
      Name = "nat_ex_1"
  }
}
