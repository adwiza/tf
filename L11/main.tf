provider "aws" {
  region = "eu-west-3"
}

variable "env" {
  default = "prod"
}

variable "prod_owner" {
  default = "Acid Wizard"
}

variable "noprod_owner" {
  default = "Some other person"
}

variable "ec2_size" {
  default = {
    "prod"  = "t3.medium"
    "dev"   = "t2.micro"
    "stage" = "t2.small"
  }
}

resource "aws_instance" "my_webserver1" {
    ami           = "ami-0cb0b94275d5b4aec"
#   instance_type = var.env == "prod" ? "t2.large" : "t2.micro"
    instance_type = var.env == "prod" ? var.ec2_size["prod"] : var.ec2_size["dev"]

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_instance" "my_webserver2" {
  ami           = "ami-0cb0b94275d5b4aec"
  instance_type = lookup(var.ec2_size, var.env)

  tags = {
    Name  = "${var.env}-server"
    Owner = var.env == "prod" ? var.prod_owner : var.noprod_owner
  }
}

resource "aws_instance" "my_dev_bastion" {
  count         = var.env == "dev" ? 1 : 0
  ami           = "ami-0cb0b94275d5b4aec"
  instance_type = "t2.micro"

  tags = {
    Name = "Bastion host"
  }
}

