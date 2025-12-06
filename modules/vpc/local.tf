locals {
  owner                    = var.owner
  project                  = var.project
  environment              = var.environment
  vpc_name                 = var.vpc_name
  igw_name                 = var.igw_name
  cidr_block               = var.cidr_block
  private_subnet_name      = var.private_subnet_name
  private_subnet_cidr      = var.private_subnet_cidr
  public_subnet_cidr       = var.public_subnet_cidr
  public_subnet_name       = var.public_subnet_name
  availability_zone        = var.availability_zone
  private_route_table_name = var.private_route_table_name
  ports_in                 = [443, 80, 22, 3389, 445, 8080]
  ports_out                = [80, 443, 22, 3389, 445, 8080]
  ec2_name                 = "${var.project}-${var.environment}-ec2"
}
