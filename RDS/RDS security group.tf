resource "aws_security_group" "DB_private_SG" {
  name = "rds_sg"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = var.RDS_port
    to_port     = var.RDS_port
    protocol    = "tcp"
    cidr_blocks = [var.VPC_CIDR]
  }
  

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.ALL_ROUTE_IP4]
    ipv6_cidr_blocks = [var.ALL_ROUTE_IP6]
  }
}