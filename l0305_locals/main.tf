locals {
  ex_instance_type = "t3.nano"
}

resource "aws_instance" "l0305" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = local.ex_instance_type
}

