module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "3.14.2"
  name           = "om_ecs_provisioning"
  cidr           = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  tags = {
    "env"       = "om"
    "Name"      = "om-vpc"
  }

}

data "aws_vpc" "main" {
  id = module.vpc.vpc_id
}