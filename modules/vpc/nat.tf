resource "aws_eip" "natgw_eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "natgw_nat_gateway" {
  allocation_id = aws_eip.natgw_eip.id
  subnet_id = aws_subnet.public_subnet.id
  tags = {
    name = lower("${var.vpc_name}_natgw")
  }
}