aws_region   = "us-east-1"
project_name = "api-infra"
environment  = "dev"

vpc_name = "dev-vpc"
vpc_cidr = "10.0.0.0/16"

vpc_azs = ["us-east-1a", "us-east-1b"]

private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

instance_type = "t2.micro"
ami_id        = "ami-0c02fb55956c7d316"

db_name     = "devdb"
db_username = "postgres"
db_password = "devpassword"

tags = {
  Environment = "dev"
  Terraform   = "true"
}