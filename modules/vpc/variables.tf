variable "vpc_name" {
  type        = string
  description = "Name tag for the VPC"
}
variable "igw_name" {
  type        = string
  description = "Name tag for the Internet Gateway"
}
variable "owner" {
  type        = string
  description = "Owner tag used for all resources"
}
variable "project" {
  type        = string
  description = "Project tag used for all resources"
}
variable "environment" {
  type        = string
  description = "Environment tag used for dev/stage/prod"
}
variable "cidr_block" {
  type        = string
  description = "CIDR block for VPC"
}
variable "private_subnet_name" {
  type        = string
  description = "Private Subnet Name"
}
variable "private_subnet_cidr" {
  type        = string
  description = "Private Subnet CIDR Range"
}
variable "public_subnet_name" {
  type        = string
  description = "public Subnet Name"
}
variable "public_subnet_cidr" {
  type        = string
  description = "public Subnet CIDR Range"
}
variable "availability_zone" {
  type        = string
  description = "Private Subnet Availability Zone"
}

variable "private_route_table_name" {
  type        = string
  description = "Private Route Table Name"
}

variable "service_ports" {
  type        = list(number)
  description = "List of TCP ports to allow in the security group"
  default     = [22, 80, 443, 3389, 445, 8080]
}

variable "ami" {
  #type        = map(string)
  description = "Map of AWS region to AMI ID"
}

variable "aws_region" {
  type        = string
  description = "AWS region to deploy resources in"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "Key pair name for EC2 instances"
}
