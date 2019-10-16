variable "cidr_block" {
  default     = ""
  description = "IP range for VPC"
}

variable "vpc_name" {
  default     = "tf-vpc-ecomm-res"
  description = "This is the name of the VPC"
}

####
# More info: https://www.terraform.io/docs/providers/aws/d/availability_zones.html
###
variable "availability_zones" {
  type = "list"
}

variable "web_svr_subnets" {
  type = "list"
}