# パブリックサブネット
resource "aws_subnet" "public" {
  vpc_id = aws_vpc.ex.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1a"
  tags = {
      Name = "public"
  }
}

# プライベートサブネット
resource "aws_subnet" "private" {
  vpc_id = aws_vpc.ex.id
  cidr_block = "10.0.64.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-1a"
  tags = {
      Name = "private"
  }
}
