resource "aws_security_group" "l0309_sg_ec2" {
  name = "l0309-sg-ec2"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "l0309" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = "t3.nano"
  vpc_security_group_ids = [aws_security_group.l0309_sg_ec2.id]

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}

output "l0309_public_dns" {
  value = aws_instance.l0309.public_dns
}
