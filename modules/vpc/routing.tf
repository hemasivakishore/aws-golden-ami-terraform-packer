resource "aws_route_table" "private-route-table" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = local.private-route-table-name
        Owner = local.owner
        Project = local.project
        environment = local.environment
        Terraform_Managed = "true"
        Managed_By = "terraform"
        Created_By = "terraform"
        route_table_type = "Private"
    }
}

resource "aws_route_table_association" "private-route-table-association" {
    subnet_id = aws_subnet.private-subnet.id
    route_table_id = aws_route_table.private-route-table.id
}