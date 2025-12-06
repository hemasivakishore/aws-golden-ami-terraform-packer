resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    enable_dns_hostnames = true
    enable_dns_support  = true
    tags = {
        Name = var.vpc_name
        Owner = local.owner
        Project = local.project
        environment = local.environment
        Terraform_Managed = "true"
        Managed_By = "terraform"
        Created_By = "terraform"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = var.igw_name
        Owner = local.owner
        Project = local.project
        environment = local.environment
        Terraform_Managed = "true"
        Managed_By = "terraform"
        Created_By = "terraform"
    }
}