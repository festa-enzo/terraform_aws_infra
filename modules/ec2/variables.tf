variable "instance_type" {
  type = string
  default = "t3.micro"
}

variable "ami_id" {
  type = string
  default = "ami-0c02fb55956c7d316"
}

variable "min_size" {
  type = number
  default = 2
}

variable "max_size" {
  type = number
  default = 4
}

variable "desired_capacity" {
  type = number
  default = 2
}

variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnets" {
  type = list(string)
}

variable "app_port" {
  type    = number
  default = 80
}

variable "key_name" {
  type    = string
  default = null
}

