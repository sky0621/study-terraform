resource "aws_instance" "ch03_example" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = "t3.micro"
}
