provider "aws" {
  region = "eu-west-3"
}

data "aws_region" "current" {}
data "aws_availability_zones" "avalable" {}

locals {
  full_project_name = "${var.environment}-${var.project_name}"
  project_owner     = "${var.owner} owner of ${var.project_name}"
}

locals {
  az_list  = join(",", data.aws_availability_zones.avalable.names)
  region   = data.aws_region.current.description
  location = "In ${local.region} there are AZ: ${local.az_list}"
}

# resource "aws_eip" "my_static_ip" {
#   tags = {
#     Name          = "Static IP"
#     Owner         = var.owner
#     Project       = local.full_project_name
#     Project_owner = local.project_owner
#     region_azs    = local.az_list
#     location      = local.location
#   }
# }

resource "null_resource" "command1" {
  provisioner "local-exec" {
    command = "echo Terraform START: $(date) >> log.txt"
  }
}

resource "null_resource" "command2" {
  provisioner "local-exec" {
    command = "ping -c 5 www.google.com"
  }
  depends_on = [null_resource.command1]
}

resource "null_resource" "command3" {
  provisioner "local-exec" {
    command     = "print('Hello world')"
    interpreter = ["python3", "-c"]
  }
}

resource "null_resource" "command4" {
  provisioner "local-exec" {
    command = "echo $NAME1 $NAME2 $NAME3 >> names.txt"
    environment = {
      NAME1 = "Vasya"
      NAME2 = "Petya"
      NAME3 = "Kolya"
    }
  }
}

resource "aws_instance" "myserver" {
  ami = "ami-0cb0b94275d5b4aec"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo Hello from AWS Instance Creation!"
  }
}
resource "null_resource" "command5" {
  provisioner "local-exec" {
    command = "echo Terraform END: $(date) >> log.txt"
  }
  depends_on = [null_resource.command1, null_resource.command2, null_resource.command3, null_resource.command4, aws_instance.myserver]
}