module "my_RDS" {
 source = "./RDS"
   ## inputs module
   allocated_storage  =10
   max_allocated_storage=20
   db_name ="mydb"
   engine = "mysql"
   engine_version="5.7"
   instance_class= "db.t3.micro"   
   username ="foo"
   password ="123456789"
   parameter_group_name= "default.mysql5.7"
   RDS_port=3306
   ALL_ROUTE_IP4 = var.ALL_ROUTE_IP4
   ALL_ROUTE_IP6 = var.ALL_ROUTE_IP6
   VPC_CIDR= var.VPC_CIDR
   vpc_id= module.my_network.vpc_id
  priv_sub_1=module.my_network.priv_sub_1
  priv_sub_2=module.my_network.priv_sub_2
  
    }
   