resource "aws_instance" "bastionhost1" {
  ami                     = var.AMD_ID
  instance_type           = var.INSTANCE_TYPE
  subnet_id               = aws_subnet.public_sub1.id
  vpc_security_group_ids  = [aws_security_group.public_SG.id]
  iam_instance_profile    = aws_iam_instance_profile.test_instance_profile.name
  key_name                = aws_key_pair.tf-key-pair.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo $(aws secretsmanager get-secret-value --secret-id ${var.COMPANY_NAME}-private-key --query SecretString --output text) > /home/ec2-user/${var.KEY_NAME}.pem
              chown ec2-user:ec2-user ${var.KEY_NAME}.pem
              chmod 400 /home/ec2-user/${var.KEY_NAME}.pem
              EOF
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inventory"
  }
  tags = {
    Name = "${var.COMPANY_NAME}_pc-ec2-1"
  }
  
}

resource "aws_instance" "bastionhost2" {
 ami                     = var.AMD_ID
 instance_type           = var.INSTANCE_TYPE
 subnet_id               =  aws_subnet.public_sub2.id
 vpc_security_group_ids  = [aws_security_group.public_SG.id]
 iam_instance_profile    = aws_iam_instance_profile.test_instance_profile.name
 key_name                = aws_key_pair.tf-key-pair.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo $(aws secretsmanager get-secret-value --secret-id ${var.COMPANY_NAME}-private-key --query SecretString --output text) > /home/ec2-user/${var.KEY_NAME}.pem
              chown ec2-user:ec2-user ${var.KEY_NAME}.pem
              chmod 400 /home/ec2-user/${var.KEY_NAME}.pem
              EOF
  provisioner "local-exec" {
    command = "echo ${self.public_ip} >> inventory"
  }
  tags = {
    Name = "${var.COMPANY_NAME}_pc-ec2-2"
  }
}
