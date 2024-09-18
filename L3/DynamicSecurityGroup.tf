provider "aws" {}

resource "aws_security_group" "dynamic_security_group" {
  name        = "Dynamic security group"
  description = "My dynamic security group"

}

resource "aws_vpc_security_group_ingress_rule" "ingress_rule_ssh" {
  security_group_id = aws_security_group.dynamic_security_group.id
  cidr_ipv4         = "10.10.0.0/16"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.dynamic_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}