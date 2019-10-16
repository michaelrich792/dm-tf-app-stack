##########################
# Creating the subnets available for infrastructure in region
# - Defining public subnets
# - Defining private subnets
# - EIP
# - NAT Gwy
##########################


### PUBLIC ###

resource "aws_subnet" "tf-ecomm-sub-PUBLIC" {
  count                   = "${length(var.availability_zones)}"
  vpc_id                  = "${aws_vpc.tf-vpc-ecomm-res.id}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 4, count.index + length(var.availability_zones))}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = "true"

  tags = {
    Name  = "tf-pub-subnets ${element(var.availability_zones, count.index)}"
    Owner = "Michael Richardson"

  }

}
###### PRIVATE #####

resource "aws_subnet" "tf-ecomm-sub-PRIVATE" {
  count                   = "${length(var.availability_zones)}"
  vpc_id                  = "${aws_vpc.tf-vpc-ecomm-res.id}"
  #cidr_block              = "${cidrsubnet(var.cidr_block, 4, count.index + 10)}"
  cidr_block              = "${cidrsubnet(var.cidr_block, 4, count.index + length(var.availability_zones))}"
  availability_zone       = "${element(var.availability_zones, count.index)}"
  map_public_ip_on_launch = "false"

  tags = {
    Name  = "tf-pri-subnets ${element(var.availability_zones, count.index)}"
    Owner = "Michael Richardson"

  }

}

resource "aws_eip" "tf-eip-res" {
  count = "${length(var.availability_zones)}"
  vpc   = "true"

  tags = {
    Name = "tf-eip - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_nat_gateway" "tf-nat-gwy" {
  count         = "${length(var.availability_zones)}"
  subnet_id     = "${element(aws_subnet.tf-ecomm-sub-PUBLIC.*.id, count.index)}"
  allocation_id = "${element(aws_eip.tf-eip-res.*.id, count.index)}"

  tags = {
    Name = "tf-nat-gwy - ${element(var.availability_zones, count.index)}"
  }
}
