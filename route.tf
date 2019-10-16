#############################
#
# Route traffic from subnets.
#- Routes
#- Route tables
#- Route associations
#############################

resource "aws_route_table" "tf-rt-table-PUBLIC-res" {
  vpc_id = "${aws_vpc.tf-vpc-ecomm-res.id}"
  tags = {
    Name = "tf-Route-PUBLIC-Table - ${var.vpc_name}"
  }
}
resource "aws_route" "tf-route-cidr-res" {
  route_table_id         = "${aws_route_table.tf-rt-table-PUBLIC-res.id}"
  gateway_id             = "${aws_internet_gateway.tf-ecomm-igw.id}"
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route_table_association" "rt-assoc-public" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.tf-ecomm-sub-PUBLIC.*.id, count.index)}"
  route_table_id = "${aws_route_table.tf-rt-table-PUBLIC-res.id}"
}
############ PRIVATE ROUTE TABLE
resource "aws_route_table" "tf-rt-table-PRIVATE-res" {
  count  = "${length(var.availability_zones)}"
  vpc_id = "${aws_vpc.tf-vpc-ecomm-res.id}"
  tags = {
    #Name = "tf-Route-PRIVATE-Table - ${var.vpc_name}"
    Name = "tf-Route-PRIVATE-Table - ${element(var.availability_zones, count.index)}"
  }
}

resource "aws_route" "tf-route-ng-res" {
  count                  = "${length(var.availability_zones)}"
  route_table_id         = "${element(aws_route_table.tf-rt-table-PRIVATE-res.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.tf-nat-gwy.*.id, count.index)}"
}

resource "aws_route_table_association" "routetable-assoc-private" {
  count          = "${length(var.availability_zones)}"
  subnet_id      = "${element(aws_subnet.tf-ecomm-sub-PRIVATE.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.tf-rt-table-PRIVATE-res.*.id, count.index)}"
}

