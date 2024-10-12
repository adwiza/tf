provider "aws" {
  region = "eu-west-3"
}

variable "name" {
  default = "petya"
}

resource "random_password" "rds_password" {
  length           = 12
  special          = true
  override_special = "#!$&"
  keepers = {
    keeper1 = var.name

  }
}

resource "aws_ssm_parameter" "rds_password" {
  name        = "/prod/mysql"
  description = "Master Password for RDS Mysql"
  type        = "SecureString"
  value       = random_password.rds_password.result
}

data "aws_ssm_parameter" "my_rds_password" {
  name = "/prod/mysql"

  depends_on = [aws_ssm_parameter.rds_password]
}

resource "aws_db_instance" "my_db" {
  identifier             = "prod-rds"
  allocated_storage      = 20
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "8.0"                                       # Specify your desired MySQL version
  instance_class         = "db.t3.micro"                               # Choose an instance type
  db_name                   = "mydatabase"                                # Initial database name
  username               = "admin"                                     # Master username
  password               = aws_ssm_parameter.rds_password.value        # Get password from SSM
  skip_final_snapshot    = true                                        # Set to false for production environments
  apply_immediately      = true

  tags = {
    Name = "My RDS Instance"
  }
}