provider "aws" {
	region = "ap-northeast-1"
}

resource "aws_vpc" "study_tf_vpc" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = true
	enable_dns_hostnames = true
	tags {
		Name = "study"
	}
}

