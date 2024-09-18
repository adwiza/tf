output "server_web_instance_id" {
  value = aws_instance.my_server_web
}

output "server_app_instance_id" {
  value = aws_instance.my_server_app
}

output "server_db_instance_id" {
  value = aws_instance.my_server_db
}

output "server_public_ip_address" {
  value = aws_eip.my_static_ip.public_ip
}

output "server_sg_id" {
  value = aws_security_group.my_server.id
}

output "server_sg_arn" {
  value = aws_security_group.my_server.arn
  description = "This is security group ARN"
}