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
  value = aws_subnet.private_subnet.id
}

output "private_route_table_id" {
  value = aws_route_table.private_route_table.id
}

output "sg_id" {
  value = aws_security_group.allow_all.id
}

output "natgw_id" {
  value = aws_nat_gateway.natgw_nat_gateway.id
}

output "eip_public_ip" {
  value = aws_eip.natgw_eip.public_ip
}

output "private_instance_id" {
  value = aws_instance.private_instance.id
}

output "private_instance_private_ip" {
  value = aws_instance.private_instance.private_ip
}
