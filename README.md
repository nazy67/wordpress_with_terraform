# Wordpress with Terraform

## Prerequisites:
   - AWS account
   - Terraform installed version 0.14
   - SSL Certificate
   - Existing SSH key
   - Domain Name

## Usage
```
git clone https://github.com/nazy67/wordpress_with_terraform.git

terraform init

terraform plan  -var-file=tfvars/dev.tf

terraform apply -var-file=tfvars/dev.tf
```

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

#### VPC
The content of this Repository is reusable and it will provision `VPC` with CIDR 10.0.0.0/16, with  `3 Public subnets` and `3 Private subnets` all the values for subnets are given in tfvars/dev.tf:

```
# Subnet

subnet_azs         = ["us-east-1a", "us-east-1b","us-east-1c"  ]
pub_cidr_subnet  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
priv_cidr_subnet = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
```

Our VPC is configured with `count` meta-argument with `index`, `element`, `lenght` functions and for tags `locals` with `merge` function. When we have similar (repeating) resources such as public/private subnets and public/private route table associations we can use count.index to avoid it duplicating. With one public/private subnet resource block we are able to provision three public/private subnets, same with Route table association (where 3 Public subnets associated with `Public-RT` attached to Internet Gateway, and 3 Private subnets associated with `Private-RT` which is attached to Nat Gateway).

`Internet Gateway (IGW)` comes around when we bring the Internet (o.o.o.o/o) which is created and attached to to VPC. For Private subnets Internet comes with `NAT Gateway` which will be sitting on Public subnet, an Elastic IP (EIP) also  created and attached to it. My `frontend` and `backend` will be sitting on Private subnets for security reasons, only access to to webserver will be form Bastion Host, which is sitting on a Public subnet. 

#### Security groups:

  - Application Load balancer security group with ports 443(HTTPS) and 80(HTTP) open to 0.0.0.0/0.
  - RDS security group with ports 3306(MySQL) open to Webserver security group and local machine. 
  - Webserver Security group with ports 3306(MySQL) open to RDS's Security Group, and HTTP port 80 open to ALB Security Group.
  
#### Application Load Balancer.

Target group gets created first with health check enabled, since our target type is an `instance`, in our case it will be `"${var.env}_wordpress"` instance, also `HTTP` and `HTTPS` Listener rules will be created both of them forwarded to target group. Application Load Balancer's scheme is internet facing (because we want our customers to see our website), for subnets values list of `Public subnets` are given otherwise it won’t work. Because only public subnets are connected to `IGW` (they have access to the Internet), if you choose `Private subnets` it will keep hitting your `NAT gateway` and eventually it will drop the connection. For Certificate arn I passed the data source `aws_acm_certificate` where Terraform will go and get the existing resource in our case is Certificate, `ACM Certificate` makes your website secure if you don't have one you can always create it.

## Useful Links

## Notes 

The following  plugins are required to be installed and activated in the WordPress:
```
- JSM force ssl. (JSM's Force HTTP to HTTPS (SSL) – Simple, Safe, Reliable, and Fast!)

- Simple 301 redirect. (Redirection)
```
These plugins helps you to make your application secure , without redirecting  your HTTP/80 listener to HTTPS/443.
