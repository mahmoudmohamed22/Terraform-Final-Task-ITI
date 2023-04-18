#outputs RDS module 
output "security_group_id" {
  value       = aws_security_group.elasticCache_private_SG.id
}
#  output "aws_elasticache_cluster_endpoint" {
#   value = aws_elasticache_cluster.elastic_cache.cache_nodes.0.endpoint
#  }

  