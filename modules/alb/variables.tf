variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnets" {
  type = list(string)
}

# integração com compute
variable "app_security_group_id" {
  type = string
}

variable "asg_name" {
  type = string
}