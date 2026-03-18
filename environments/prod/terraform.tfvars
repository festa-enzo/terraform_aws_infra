aws_region   = "us-east-1"
project_name = "api-infra"
environment  = "prod"

vpc_name = "prod-vpc"
vpc_cidr = "10.1.0.0/16"

vpc_azs = ["us-east-1a", "us-east-1b"]

private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]

instance_type = "t3.medium"
ami_id        = "ami-0c02fb55956c7d316"

db_name     = "proddb"
db_username = "postgres"
db_password = "SUPER-SECURE-PASSWORD"

tags = {
  Environment = "prod"
  Terraform   = "true"
}