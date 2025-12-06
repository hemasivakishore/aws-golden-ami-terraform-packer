variable "vpc_name" {
    type = string
    description = "Name tag for the VPC"
}
variable "igw_name" {
    type = string
    description = "Name tag for the Internet Gateway"
}
variable "owner" {
    type = string
    description = "Owner tag used for all resources"
}
variable "project" {
    type = string
    description = "Project tag used for all resources"
}
variable "environment" {
    type = string
    description = "Environment tag used for dev/stage/prod"
}
variable "cidr_block" {
    type = string
    description = "CIDR block for VPC"
}
variable "private_subnet_name" {
    type = string
    description = "Private Subnet Name"
}
variable "private-subnet-cidr" {
    type = string
    description = "Private Subnet CIDR Range"
}
variable "availability_zone" {
    type = string
    description = "Private Subnet Availability Zone"
}

variable "private-route-table-name" {
    type = string
    description = "Private Route Table Name"
}