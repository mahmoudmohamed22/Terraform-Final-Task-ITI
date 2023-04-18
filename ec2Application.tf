resource "aws_instance" "ec2_app1" {
  ami                     = var.AMD_ID
  instance_type           = var.INSTANCE_TYPE
  subnet_id               = module.my_network.priv_sub_1
  vpc_security_group_ids  = [module.my_network.private_SG]
  iam_instance_profile    = module.my_secuirty.instance_profile_name
  key_name                = module.my_secuirty.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo $(aws secretsmanager get-secret-value --secret-id ${var.COMPANY_NAME}_secrets --query SecretString --output text) > /home/ec2-user/${var.KEY_NAME}.pem
              chown ec2-user:ec2-user ${var.KEY_NAME}.pem
              chmod 400 /home/ec2-user/${var.KEY_NAME}.pem
              sudo dnf install mariadb105 -y
              EOF

  
  tags = {
    Name = "${var.COMPANY_NAME}_pv-ec2-1"
  }
  
}

resource "aws_instance" "ec2_app2" {
  ami                     = var.AMD_ID
  instance_type           = var.INSTANCE_TYPE
  subnet_id               = module.my_network.priv_sub_2
  vpc_security_group_ids  = [module.my_network.private_SG]
  iam_instance_profile    = module.my_secuirty.instance_profile_name
  key_name                = module.my_secuirty.key_name
  user_data = <<-EOF
              #!/bin/bash
              echo $(aws secretsmanager get-secret-value --secret-id ${var.COMPANY_NAME}_secrets --query SecretString --output text) > /home/ec2-user/${var.KEY_NAME}.pem
              chown ec2-user:ec2-user ${var.KEY_NAME}.pem
              chmod 400 /home/ec2-user/${var.KEY_NAME}.pem
              sudo dnf install mariadb105 -y
              EOF
  tags = {
    Name = "${var.COMPANY_NAME}_pv-ec2-2"
  }
}
