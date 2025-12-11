terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "golden-ami" {
  source                   = "git::https://github.com/hemasivakishore/aws-golden-ami-terraform-packer.git//modules/vpc?ref=main"
  vpc_name                 = "golden-image"
  igw_name                 = "golden-igw"
  owner                    = "golden-ami"
  project                  = "golden-project"
  environment              = "golden-env"
  cidr_block               = "192.168.0.0/16"
  private_subnet_name      = "golden-private-subnet"
  private_subnet_cidr      = "192.168.1.0/24"
  public_subnet_name       = "golden-public-subnet"
  public_subnet_cidr       = "192.168.2.0/24"
  availability_zone        = "us-east-1a"
  private_route_table_name = "golden-private-route-table"
  service_ports            = [22, 80, 443, 3389, 445, 8080]
  ami                      = "ami-0ecb62995f68bb549"
  aws_region               = "us-east-1"
  key_name                 = "vhsk"
}
