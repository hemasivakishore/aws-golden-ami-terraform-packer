locals {
    owner = var.owner
    project = var.project
    environment = var.environment
    vpc_name = var.vpc_name
    igw_name = var.igw_name
    cidr_block = var.cidr_block
    private_subnet_name = var.private_subnet_name
    private-subnet-cidr = var.private-subnet-cidr
    availability_zone = var.availability_zone
    private-route-table-name = var.private-route-table-name
    ports_in = [443, 80, 22, 3389, 445, 8080]
    ports_out = [80, 443, 22, 3389, 445, 8080]
}