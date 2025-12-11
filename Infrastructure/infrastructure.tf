terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "aws-golden-ami-terraform-packer"
    key    = "aws-golden-ami-backend"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "The AMI ID to be used for the instances"
  type        = string
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
  ami                      = var.ami
  aws_region               = "us-east-1"
  key_name                 = "vhsk"
}
