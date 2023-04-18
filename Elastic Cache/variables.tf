# inputs
variable "cluster_id" {
  type=string
}

variable "engine" {
  type=string
}

variable "node_type" {
  type=string
}

variable "num_cache_nodes" {
  type=number
}
variable "parameter_group_name" {
  type=string
}
variable "engine_version" {
  type=string
}

variable "port" {
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
 
