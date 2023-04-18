resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = [var.priv_sub_1,var.priv_sub_2]
  tags = {
    Name = "My DB subnet group"
  }
}