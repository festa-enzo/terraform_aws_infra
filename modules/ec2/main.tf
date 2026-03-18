resource "aws_security_group" "app_sg" {
    name = "app=ec2=sg"
    description = "Security group for application"
    vpc_id = module.vpc.vpc_id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "SSH (opcional)"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_launch_template" "app_template" {
    name_prefix = "app-template"
    image_id = "ami-0c02fb55956c7d316"
    instance_type = "t3.micro"

    vpc_security_group_ids = [aws_security_group.app_sg.id]

    user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd

echo "Hello from Auto Scaling instance" > /var/www/html/index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "app-instance"
    }
  }
}

resource "aws_autoscaling_group" "app_asg" {
    name = "app-asg"

    desired_capacity = 2
    min_size = 2
    max_size = 4

    vpc_zone_identifier = module.vpc.private_subnets

    launch_template {
      id = aws_launch_template.app_template
      version = "$Latest"
    }

    health_check_type = "EC2"

    tag {
      key = "name"
      value = "app-asg-instance"
      propagate_at_launch = true
    }
}