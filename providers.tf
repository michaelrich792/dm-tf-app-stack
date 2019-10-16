#########################################
# Using AWS as a Provider
#########################################

provider "aws" {
  profile = "michael-uk-aws-hotmail"
  version = "~> 2.6"
  region  = "eu-west-2"
}

terraform {
  required_version = ">= 0.12.04"
  ##########################################
  # Setting up the remote tfstate file on s3
  ##########################################
  backend "s3" {
    bucket  = "ubuntu33"
    key     = "dm-tf-michael/terraform.tfstate"
    region  = "eu-west-2"
    encrypt = "true"
  }
}
