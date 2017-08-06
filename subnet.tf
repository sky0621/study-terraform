resource "aws_subnet" "study_tf_public_web" {
	vpc_id = "${aws_vpc.study_tf_vpc.id}"
	cidr_block = "10.0.0.0/24"
	availability_zone = "ap-northeast-1a"
	map_public_ip_on_launch = true
	tags {
		Name = "studyTerraform_pub_web"
	}
}

resource "aws_subnet" "study_tf_private_db" {
	vpc_id = "${aws_vpc.study_tf_vpc.id}"
	cidr_block = "10.0.1.0/24"
	availability_zone = "ap-northeast-1a"
	tags {
		Name = "studyTerraform_pri_db"
	}
}

