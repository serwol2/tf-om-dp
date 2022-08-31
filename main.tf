provider "aws" {
  region  = "us-east-1"
 # version = "~> 4.0"
}


terraform {
backend "s3" {
    bucket = "om-test-terraform-states"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}