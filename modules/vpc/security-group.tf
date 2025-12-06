resource "aws_security_group" "allow-all" {
    name = "${var.vpc_name}-sg-allow-all"
    description = "Allow all inbound rules and traffic"
    vpc_id = aws_vpc.vpc.id

    dynamic "ingress" {
        for_each = var.service_ports
        content {
            from_port = ingress.value
            to_port = ingress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    dynamic "egress" {
        for_each = toset(local.ports_out)
        content {
            from_port = egress.value
            to_port = egress.value
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "${var.vpc_name}-sg-allow-all"
        environment = local.environment
        project = local.project
    }
    lifecycle {
        create_before_destroy = true
    }
}