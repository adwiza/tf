resource "vault_generic_secret" "postgres_credentials" {
  path = "${var.env}/rds/${var.db_name}/"

  data_json = jsonencode({
    DSN      = "postgresql://${postgresql_role.db_user.name}:${random_password.db_password.result}@${var.postgres_host}:${var.postgres_port}/${var.db_name}"
    username = postgresql_role.db_user.name
    password = random_password.db_password.result
    port     = var.postgres_port
    ip       = var.postgres_host
  })
}