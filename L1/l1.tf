provider "aws" {}

resource "aws_instance" "my_AWS_linux" {
  count         = 1
  ami           = data.aws_ami.latest_ubuntu.id
  instance_type = "t3.micro"

  tags = {
    Name    = "My Amazon server"
    Owner   = "Acid Wizard"
    Project = "Terraform lessons"
  }
}
