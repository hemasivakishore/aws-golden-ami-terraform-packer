output "vpc_name" {
    value = lower(var.vpc_name)
}

output "vpc_id" {
    value = aws_vpc.vpc.id
}

output "environment" {
    value = var.environment
}

output "private_subnet_id" {
    value = aws_subnet.private-subnet.id
}

output "private_route_table_id" {
    value = aws_route_table.private-route-table.id
}

output "sg_id" {
    value = aws_security_group.allow-all.i
}

output "natgw" {
    value = aws_nat_gateway.natgw-nat-gateway.id
}

output "eip" {
    value = aws_eip.natgw-eip.public_ip
}