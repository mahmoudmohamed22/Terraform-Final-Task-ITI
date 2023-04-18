module "my_elastic_cache" {
 source = "./Elastic Cache"

  cluster_id           = "cluster-example"
  engine               = "redis"
  node_type            = "cache.m4.large"
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  engine_version       = "3.2.10"
  port                 = 6379
   ALL_ROUTE_IP4 = var.ALL_ROUTE_IP4
   ALL_ROUTE_IP6 = var.ALL_ROUTE_IP6
   VPC_CIDR= var.VPC_CIDR
   vpc_id= module.my_network.vpc_id
  priv_sub_1=module.my_network.priv_sub_1
  priv_sub_2=module.my_network.priv_sub_2
}