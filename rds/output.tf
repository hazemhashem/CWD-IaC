output "rds_name" {
  value = aws_db_instance.rds.db_name
}
output "rds_password" {
  value = aws_db_instance.rds.password
}

output "rds_hostname" {
  value = aws_db_instance.rds.address
}
output "rds_port" {
  value = aws_db_instance.rds.port
}