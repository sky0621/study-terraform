resource "aws_internet_gateway" "study_tf_gw" {
	vpc_id = "${aws_vpc.study_tf_vpc.id}"
	tags {
		Name = "studyTerraform_gw"
	}
}

