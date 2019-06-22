# https://www.terraform.io/docs/providers/aws/r/subnet.html

# パブリックサブネット
resource "aws_subnet" "public_0" {
  vpc_id = aws_vpc.ex.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true    # パブリックIPアドレスを割り当てる必要がある場合、true
  availability_zone = "ap-northeast-1a"
  tags = {
      Name = "public_0"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id = aws_vpc.ex.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-northeast-1c"
  tags = {
      Name = "public_1"
  }
}

# プライベートサブネット
resource "aws_subnet" "private_0" {
  vpc_id = aws_vpc.ex.id
  cidr_block = "10.0.65.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-1a"
  tags = {
      Name = "private_0"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id = aws_vpc.ex.id
  cidr_block = "10.0.66.0/24"
  map_public_ip_on_launch = false
  availability_zone = "ap-northeast-1c"
  tags = {
      Name = "private_1"
  }
}
