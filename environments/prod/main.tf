# VPC
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  environment  = var.environment

  vpc_name  = var.vpc_name
  vpc_cidr  = var.vpc_cidr

  vpc_azs             = var.vpc_azs
  vpc_private_subnets = var.private_subnets
  vpc_public_subnets  = var.public_subnets

  vpc_enable_nat_gateway = true
  vpc_tags               = var.tags
}

# EC2 + ASG
module "ec2" {
  source = "../../modules.ec2"

  project_name = var.project_name
  environment  = var.environment

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  instance_type = var.instance_type
  ami_id        = var.ami_id

  min_size         = 2
  max_size         = 4
  desired_capacity = 2

  app_port = 80

  tags = {
    Project = var.tags
  }
}

# RDS
module "rds" {
  source = "../../modules/rds"

  project_name = var.project_name
  environment  = var.environment

  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets

  app_security_group_id = module.ec2.security_group_id

  db_name     = var.db_name
  db_username = var.db_username
  db_password = var.db_password
}

# ALB
module "alb" {
  source = "../../modules/alb"

  project_name = var.project_name
  environment  = var.environment

  vpc_id         = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets

  app_security_group_id = module.ec2.security_group_id
  asg_name              = module.ec2.asg_name
}

# S3
module "s3" {
  source = "../../modules/s3"

  project_name = var.project_name
  environment  = var.environment

  bucket_name = "${var.project_name}-${var.environment}-uploads"
}
