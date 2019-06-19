data "template_file" "httpd_user_data" {
  template = file("./user_data.tpl")
  vars = {
      package = "httpd"
  }
}

resource "aws_instance" "l0314_template" {
  ami = "ami-0f9ae750e8274075b"
  instance_type = "t3.nano"

  user_data = data.template_file.httpd_user_data.rendered
}
