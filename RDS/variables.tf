  ## inputs module
  variable allocated_storage {
    type=number
  } 

   variable max_allocated_storage {
    type=number
  } 
  variable db_name {
    type=string
  } 
  variable engine  {
    type=string
  } 
   variable engine_version {
    type=string
  } 
  variable instance_class  {
    type=string
  } 

   variable username {
    type=string
  } 
  variable password  {
    type=string
  } 
 
   variable parameter_group_name  {
    type=string
  } 

  variable RDS_port{
    type=number
  }

  variable "VPC_CIDR" {
    type=string
  }
  variable "ALL_ROUTE_IP4" {
    type=string
  }
   variable "ALL_ROUTE_IP6" {
    type=string
  }

  variable "vpc_id" {
    type=string
  }

  variable "priv_sub_1" {
    type=string
  }
  variable "priv_sub_2" {
    type=string
  }
 
