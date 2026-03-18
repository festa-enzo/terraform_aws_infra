output "asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "launch_template_id" {
  value = aws_launch_template.app_template.id
}

output "security_group_id" {
  value = aws_security_group.app_sg.id
}

output "target_group_attachment_ready" {
  value = aws_autoscaling_group.app_asg.name
}