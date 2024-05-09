resource "aws_secretsmanager_secret" "sct_mng" {
  name = "db-secret"
  recovery_window_in_days = 0
}

resource "aws_secretsmanager_secret_version" "sct_values" {
  secret_id     = aws_secretsmanager_secret.sct_mng.id
  secret_string = jsonencode({
    RDS_HOSTNAME   = "${var.RDS_HOSTNAME}"
    db_name       = "${var.db_name}"
    RDS_USERNAME   = "${var.RDS_USERNAME}"
    RDS_PASSWORD   = "${var.RDS_PASSWORD}"
    RDS_PORT = "${var.RDS_PORT}"

    REDIS_HOSTNAME = "${var.REDIS_HOSTNAME}"
    REDIS_PORT = "${var.REDIS_PORT}"
  })
  
}