provider "aws" {
  region = var.region
}

data "aws_region" "current" {}
data "aws_availability_zones" "available" {}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${var.project_name}"
}

locals {
  az_list  = join(",", data.aws_availability_zones.available.names)
  region   = data.aws_region.current.description
  location = "In ${local.region} there are AZ: ${local.az_list}"
}
data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server.id
  tags = merge(var.common_tags, {
    Region       = var.region,
    Name         = "${var.common_tags["Environment"]} Server IP",
    Project      = local.full_project_name,
    ProjectOwner = local.project_owner
    region_azs   = local.az_list
    location     = local.location
    }
  )

}

resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.latest_amazon_linux.id # Amazon Linux AMI
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.my_server.id]
  monitoring             = var.enable_detailed_monitoring
  tags                   = merge(var.common_tags, { Region = var.region, Name = "${var.common_tags["Environment"]} Server Build by Terraform" })
}

resource "aws_security_group" "my_server" {
  name = "My Security Group"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(var.common_tags, { Region = var.region, Name = "${var.common_tags["Environment"]} Server SecurityGroup" })
}