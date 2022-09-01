resource "aws_db_instance" "om-database" {
  allocated_storage    = 10
  engine               = "mysql"
  #engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  db_name              = "openmeetings"
  identifier           = "om-database1"
  username             = "sergey"
  password             = "samsung-1"
  #availability_zone    = "us-east-1a" # delete this in future
  parameter_group_name = "default.mysql8.0" #default:mysql-8-0
  skip_final_snapshot  = true
  #vpc_security_group_ids = ["sg-0d47cf7abb58012da"] # hardcore!!!!!
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  #aws_security_group.ec2-sg.id
  #vpc_id      = data.aws_vpc.main.id
  db_subnet_group_name = "om_ecs_provisioning"

  
  depends_on = [module.vpc]
}

# depends_on []