resource "aws_db_subnet_group" "elastic_cache_subnet_group" {
  name       = "elastic_cache_subnet_group"
  subnet_ids = [var.priv_sub_1,var.priv_sub_2]
  tags = {
    Name = "My elastic Cache subnet group"
  }
}