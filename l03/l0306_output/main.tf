resource "aws_instance" "l0306" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = "t3.nano"
}

output "l0306_instance_id" {
  value = "aws_instance.l0306.id"
}

