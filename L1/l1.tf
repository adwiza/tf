provider "aws" {}

resource "aws_instance" "my_AWS_linux" {
  count         = 1
  ami           = "ami-0cb0b94275d5b4aec"
  instance_type = "t3.micro"

  tags = {
    Name    = "My Amazon server"
    Owner   = "Acid Wizard"
    Project = "Terraform lessons"
  }
}
