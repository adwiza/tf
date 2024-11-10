terraform {
  required_providers {
    postgresql = {
      source  = "cyrilgdn/postgresql"
      version = "1.24.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "bucke-name"
    key = "dev/rds/terraform.tfstate"
    region = "eu-west-3"
  }
}

provider "postgresql" {
  host     = var.postgres_host
  port     = var.postgres_port
  username = var.postgres_admin_user
  password = var.postgres_admin_password
  #   sslmode  = "require"
}

provider "vault" {
  address = var.vault_address
}

variable "postgres_host" {
  description = "PostgreSQL host address"
}

variable "postgres_port" {
  description = "PostgreSQL port"
  default     = 5432
}

variable "postgres_admin_user" {
  description = "Admin username for PostgreSQL"
}

variable "postgres_admin_password" {
  description = "Admin password for PostgreSQL"
  sensitive   = true
}

variable "vault_address" {
  description = "Vault server address"
}

variable "db_name" {
  description = "Database name"
  default     = "my_database"
}

variable "env" {
  description = "Environment"
  default     = "dev"
}
