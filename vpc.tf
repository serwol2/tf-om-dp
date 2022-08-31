module "vpc" {
  source         = "terraform-aws-modules/vpc/aws"
  version        = "3.14.2"
  name           = "om_ecs_provisioning"
  cidr           = "10.0.0.0/16"
  azs            = ["us-east-1a", "us-east-1b"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  database_subnets  = ["10.0.3.0/24", "10.0.4.0/24"]
  create_database_subnet_group           = true
  #database_subnet_group_name = "om-db-subnet-group"
  tags = {
    "Name"      = "om-vpc"
  }

}



data "aws_vpc" "main" {
  id = module.vpc.vpc_id
}

# resource "aws_db_subnet_group" "om-subnet-group" {
#   name       = "om-subnet-group"
#   subnet_ids = [aws_subnet.frontend.id, aws_subnet.backend.id]

#   tags = {
#     Name = "My DB subnet group"
#   }
# }