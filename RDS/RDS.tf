resource "aws_db_instance" "mydb" {
  allocated_storage    = var.allocated_storage
  max_allocated_storage= var.max_allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name # attach with private subnet group
  vpc_security_group_ids=[aws_security_group.DB_private_SG.id] # attach with secuirty group
  delete_automated_backups=true
}