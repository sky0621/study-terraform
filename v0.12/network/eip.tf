# https://www.terraform.io/docs/providers/aws/d/eip.html

# Elastic IP Address
resource "aws_eip" "nat_gateway_0" {
  vpc = true
  depends_on = [aws_internet_gateway.ex]
  tags = {
      Name = "eip_0"
  }
}

resource "aws_eip" "nat_gateway_1" {
  vpc = true
  depends_on = [aws_internet_gateway.ex]
  tags = {
      Name = "eip_1"
  }
}
