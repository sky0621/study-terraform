resource "aws_route_table" "study_tf_public_rtb" {
	vpc_id = "${aws_vpc.study_tf_vpc.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.study_tf_gw.id}"
	}
	tags {
		Name = "studyTerraform_route"
	}
}

