provider "aws" {}

resource "aws_instance" "my_server_web" {
  ami                    = "ami-0cb0b94275d5b4aec" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_server.id]

  tags = {
    Name = "Server-Web"
  }

  depends_on = [ aws_instance.my_server_db, aws_instance.my_server_app ]
}

resource "aws_instance" "my_server_app" {
  ami                    = "ami-0cb0b94275d5b4aec" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_server.id]

  tags = {
    Name = "Server-Application"
  }

  depends_on = [ aws_instance.my_server_db ]

  lifecycle {
  prevent_destroy = false
  ignore_changes = [ ami, user_data ]
  create_before_destroy = true
  }
}

resource "aws_instance" "my_server_db" {
  ami                    = "ami-0cb0b94275d5b4aec" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_server.id]

  tags = {
    Name = "Server-Database"
  }

  lifecycle {
  prevent_destroy = false
  ignore_changes = [ ami, user_data ]
  create_before_destroy = true
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_server_web.id
}

resource "aws_security_group" "my_server" {
  name        = "WebSever security group"
  description = "My first security group"

  tags = {
    Name = "my_server"
  }
}

resource "aws_vpc_security_group_ingress_rule" "my_server_ipv4" {
  security_group_id = aws_security_group.my_server.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_server.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
