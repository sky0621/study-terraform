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

resource "aws_route_table_association" "study_tf_public_a" {
	subnet_id = "${aws_subnet.study_tf_public_web.id}"
	route_table_id = "${aws_route_table.study_tf_public_rtb.id}"
}

