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