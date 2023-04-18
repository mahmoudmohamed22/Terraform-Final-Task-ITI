#outputs RDS module 
output "security_group_id" {
  value       = aws_security_group.DB_private_SG.id
}
output "db_instance_endpoint" {
  value       = aws_db_instance.mydb.endpoint
}