######################################
#
#Setting up Security Groups
#
######################################

resource "aws_security_group" "allow_from_webapps_to_web_servers" {
  name        = "allow_access_from_webapp"
  description = "Allow Inbound traffic from the webservers on webservers to the appication serversTLS"
  vpc_id      = "${aws_vpc.tf-vpc-ecomm-res.id}"

  lifecycle {
    create_before_destroy = "true"
  }


  ingress {
    # TLS (post to allow inbound 8080 from web server public subnets)
    from_port = 8080
    to_port   = 8080
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    cidr_blocks = "${var.web_svr_subnets}"
  }

  ingress {
    # TLS (post to allow inbound 8080 from web server public subnets)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    cidr_blocks = "${var.web_svr_subnets}"
  }

  egress {
    # TLS (change to whatever ports you need)
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    # Please restrict your egress to only necessary IPs and ports.
    cidr_blocks = "${var.web_svr_subnets}"
  }
  tags = {
    Name = "Security rules from app --> web servers"
  }
}