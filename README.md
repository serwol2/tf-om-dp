# Provisioning VPC, ECS, ALB and EC2 for openmeetings-dp using Terraform

- Virtual Private Cloud (VPC) with 2 public subnets in 2 availability zones
- Elastic Container Service (ECS)
- Application Load Balancer (ALB)
- EC2 instance for Kurento Media Server 
- Database in Relational Database Service (RDS) (in future)
## How to create the infrastructure?
1. terraform init
2. terraform plan
3. terraform apply

Note: it can take about 10 minutes to provision all resources.
## How to delete the infrastructure?
1. Terminate ALB and ASG
2. Run `terraform destroy`