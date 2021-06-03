# Providers variables
variable "aws_region" {
  type        = string
  description = " aws region to deploys your infra"
}

# VPC variables
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for the vpc"
}

variable "instance_tenancy" {
  type        = string
  description = "the tenancy of existing VPCs from dedicated to default instantly"
}

variable "is_enabled_dns_support" {
  type        = bool
  description = "enabling dns support"
}

variable "is_enabled_dns_hostnames" {
  type        = bool
  description = "enabling dns hostnames"
}

variable "rt_cidr_block" {
  type        = string
  description = "route table cidr block"
}

# Subnet variables
variable "subnet_azs" {
  type        = list(string)
  description = "The availabitily zones where terraform deploys your infra"
}

variable "pub_cidr_subnet" {
  type        = list(string)
  description = "cird blocks for the public subnets"
}

variable "priv_cidr_subnet" {
  type        = list(string)
  description = "cidr blocks for the private subnets"
}

# RDS variables
variable "instance_class" {
  type        = string
  description = "cidr block for the vpc"
}

variable "skip_snapshot" {
  type        = bool
  description = "skip snapshot if env is dev"
}

# Launch Template
variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

# Route 53 variables
variable "zone_name" {
  description = "Name of route 53 zone"
  type        = string
}

# Tag variables
variable "env" {
  type        = string
  description = "name of the environment"
}