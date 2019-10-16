cidr_block = "10.0.0.0/16"

vpc_name = "tf-vpc-ecomm-res"

availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

web_svr_subnets = ["10.0.64.0/20", "10.0.48.0/20", "10.0.32.0/20"]
#web_svr_subnets = "${element(aws_subnet.tf-ecomm-sub-PUBLIC.*.cidr_block)}"
