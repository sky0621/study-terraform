variable "ch0302_instance_type" {
    default = "t3.micro"
}

resource "aws_instance" "name" {
    ami = "ami-0f9ae750e8274075b"
    instance_type = var.ch0302_instance_type
}
