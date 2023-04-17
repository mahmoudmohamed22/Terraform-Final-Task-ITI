resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_main.id
  tags = {
    Name = "${var.COMPANY_NAME}_IGW"
  }
}