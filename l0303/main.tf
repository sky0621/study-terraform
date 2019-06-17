resource "aws_instance" "ch0302" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = "t3.micro"

  tags = {
      Name = "ch0302_ex"
  }

  user_data = <<EOF
    #!/bin/bash
    yum install -y httpd
    systemctl start httpd.service
EOF
}
