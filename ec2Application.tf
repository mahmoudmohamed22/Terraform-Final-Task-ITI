resource "aws_instance" "ec2_app1" {
  ami                     = var.AMD_ID
  instance_type           = var.INSTANCE_TYPE
  subnet_id               = aws_subnet.private_sub1.id
  vpc_security_group_ids  = [aws_security_group.private_SG.id]
  iam_instance_profile    = aws_iam_instance_profile.test_instance_profile.name
  key_name                = aws_key_pair.tf-key-pair.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo $(aws secretsmanager get-secret-value --secret-id ${var.COMPANY_NAME}-private-key --query SecretString --output text) > /home/ec2-user/${var.KEY_NAME}.pem
              chown ec2-user:ec2-user ${var.KEY_NAME}.pem
              chmod 400 /home/ec2-user/${var.KEY_NAME}.pem
              EOF

  
  tags = {
    Name = "${var.COMPANY_NAME}_pv-ec2-1"
  }
  
}

resource "aws_instance" "ec2_app2" {
  ami                     = var.AMD_ID
  instance_type           = var.INSTANCE_TYPE
  subnet_id               = aws_subnet.private_sub2.id
  vpc_security_group_ids  = [aws_security_group.private_SG.id]
  iam_instance_profile    = aws_iam_instance_profile.test_instance_profile.name
  key_name                = aws_key_pair.tf-key-pair.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo $(aws secretsmanager get-secret-value --secret-id ${var.COMPANY_NAME}-private-key --query SecretString --output text) > /home/ec2-user/${var.KEY_NAME}.pem
              chown ec2-user:ec2-user ${var.KEY_NAME}.pem
              chmod 400 /home/ec2-user/${var.KEY_NAME}.pem
              EOF
  tags = {
    Name = "${var.COMPANY_NAME}_pv-ec2-2"
  }
}
