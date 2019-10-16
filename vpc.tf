################
# VPC setup for out DC
# https://www.terraform.io/docs/providers/aws/r/vpc.html
################

resource "aws_vpc" "tf-vpc-ecomm-res" {
  cidr_block           = "${var.cidr_block}"
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name       = "${var.vpc_name}"
    Owner      = "Michael Richardson Team A"
    CostCentre = "1234567890"
  }
}

####################
# Internet Gateway for your VPC
# https://www.terraform.io/docs/providers/aws/r/internet_gateway.html
####################

resource "aws_internet_gateway" "tf-ecomm-igw" {
  vpc_id = "${aws_vpc.tf-vpc-ecomm-res.id}"

  tags = {
    Name = "tf-ecomm-igw"
  }
}
