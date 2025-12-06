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

resource "aws_route" "nat_rule" {
    route_table_id = aws_route_table.private-route-table.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.natgw-nat-gateway.id
    depends_on = [ aws_nat_gateway.natgw-nat-gateway ]
}