resource "aws_subnet" "private-subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = local.private-subnet-cidr
    availability_zone = local.availability_zone
    tags = {
        Name = local.private_subnet_name
        Owner = local.owner
        Project = local.project
        environment = local.environment
        Terraform_Managed = "true"
        Managed_By = "terraform"
        Created_By = "terraform"
        Subnet_Type = "Private"
    }
}