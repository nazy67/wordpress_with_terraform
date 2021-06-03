# Wordpress with Terraform

## Prerequisites:
   - AWS account
   - Terraform installed version 0.14
   - SSL Certificate
   - Existing SSH key
   - Domain Name

## Usage

git clone https://github.com/nazy67/wordpress_with_terraform.git

terraform init
terraform plan  -var-file=tfvars/dev.tf
terraform apply -var-file=tfvars/dev.tf


## Resources

- VPC
  - 3 Public Subnets
  - 3 Private Subnets
  - Public Route Table
  - Private Route Table
  - Elastic IP
  - Internet Gateway
  - Nat Gateway
  - Public/Private Route Table Association

- Security Groups
   - Webserver Security Group 
   - RDS Security Group
   - Application Load Balancer Security Group

- Application Load Balacer
  - Target Group
  - HTTP Listener
  - HTTPS Listener

- Auto scaling Group
  - Launch Template

- RDS database
  - Database Subnet Group

- DNS
  - Route 53
  - ACM Certificate


## Description

## Useful Links