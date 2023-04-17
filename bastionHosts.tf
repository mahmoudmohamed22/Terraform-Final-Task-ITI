resource "aws_instance" "bastionhost1" {
  ami                     = var.AMD_ID
  instance_type           = var.INSTANCE_TYPE
  subnet_id               = module.my_network.pub_sub_1
  vpc_security_group_ids  = [module.my_network.public_SG]
  iam_instance_profile    = module.my_secuirty.instance_profile_name
  key_name                = module.my_secuirty.key_name
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
 subnet_id               =  module.my_network.pub_sub_2
 vpc_security_group_ids  = [module.my_network.public_SG]
 iam_instance_profile    = module.my_secuirty.instance_profile_name
 key_name                = module.my_secuirty.key_name
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
