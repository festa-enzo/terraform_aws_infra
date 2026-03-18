variable "aws_region" {
    default = "us-east-1"
}
variable "project_name" {}
variable "environment" {}

variable "vpc_name" {}
variable "vpc_cidr" {}

variable "vpc_azs" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "instance_type" {}
variable "ami_id" {}

variable "db_name" {}
variable "db_username" {}
variable "db_password" {
  sensitive = true
}

variable "tags" {
  type = map(string)
}