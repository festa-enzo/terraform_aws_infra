Production-ready Infrastructure as Code (IaC) project built with Terraform to provision a highly available, scalable, and secure AWS environment for an internal API.

Architecture includes:
- Custom VPC with public and private subnets, Internet Gateway, and NAT Gateway
- EC2 Auto Scaling Group (min: 2, max: 4) using Launch Templates
- Application Load Balancer (ALB) for traffic distribution
- PostgreSQL RDS (Multi-AZ, encrypted storage, restricted access)
- S3 bucket for file uploads (versioning enabled, public access blocked)
- Modular Terraform structure with reusable components
- Multi-environment setup (dev and prod)
- Remote state management using S3 and DynamoDB (state locking)

Follows AWS and Terraform best practices for security, scalability, and maintainability.

WARNING: Before running Terraform Plan or Apply, use the AWS Configure command. He will request information in order to connect to AWS.

AWS Access Key ID:
AWS Secret Access Key:
Default region:
Default output format:
