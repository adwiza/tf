resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "postgresql_database" "db" {
  name = var.db_name
  lifecycle {
    prevent_destroy = true
  }
}

resource "postgresql_role" "db_user" {
  name     = "app_user"
  password = random_password.db_password.result
  login    = true
}

resource "postgresql_grant" "grant_privileges" {
  database    = postgresql_database.db.name
  role        = postgresql_role.db_user.name
  object_type = "database"
  privileges  = ["CONNECT", "TEMPORARY"]
  depends_on  = [random_password.db_password, postgresql_role.db_user]
}
