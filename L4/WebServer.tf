provider "aws" {}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0cb0b94275d5b4aec" # Amazon Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  user_data = templatefile("user_data.sh.tpl", {
    f_name = "Acid",
    l_name = "Wizard",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })

  tags = {
    Name = "my_webserver"
  }

  lifecycle {
  prevent_destroy = true
  ignore_changes = [ "ami", "user_data" ]
  create_before_destroy = true
}
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}
resource "aws_security_group" "my_webserver" {
  name        = "WebSever security group"
  description = "My first security group"

  tags = {
    Name = "my_webserver"
  }
}

resource "aws_vpc_security_group_ingress_rule" "my_webserver_ipv4" {
  security_group_id = aws_security_group.my_webserver.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 443
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_webserver.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
