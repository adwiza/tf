# Output the password to the screen
output "rds_password_local" {
  value     = random_password.rds_password.result
  sensitive = true
}


output "rds_password" {
  value     = data.aws_ssm_parameter.my_rds_password.value
  sensitive = true
}
