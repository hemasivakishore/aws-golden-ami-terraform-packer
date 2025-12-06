resource "aws_eip" "natgw-eip" {
    domain = "vpc"
}

resource "aws_nat_gateway" "natgw-nat-gateway" {
  allocation_id = aws_eip.natgw-eip.id
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    name = lower("${var.vpc_name}-natgw")
  }
}