# ec2.tf (inside modules/vpc or better modules/ec2)
resource "aws_instance" "private_instance" {
  ami                    = var.ami # for now a single AMI string
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = aws_subnet.private_subnet.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt-get update -y
  sudo apt-get install -y nginx
  EOF

  tags = {
    Name              = "${var.vpc_name}-private-instance"
    Owner             = var.owner
    Project           = var.project
    Environment       = var.environment
    Terraform_Managed = "true"
    Managed_By        = "terraform"
    Created_By        = "terraform"
    Instance_Type     = "private"
  }
}
