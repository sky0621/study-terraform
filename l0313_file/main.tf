resource "aws_instance" "l0313_file" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = "t3.nano"

  user_data = file("./user_data.sh")
}
