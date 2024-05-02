resource "aws_elasticache_subnet_group" "redis_subnet_group" {
  name       = "redis-subnet-group"
  subnet_ids = [ var.private_subnet_id_1,var.private_subnet_id_2]
    tags = {
    Name = "redis_subnet_group"
  }
}


resource "aws_elasticache_cluster" "redis" {
  cluster_id           = "${var.cluster_id}"
  engine               = "${var.engine_redis}"
  node_type            = "${var.node_type}"
  num_cache_nodes      = "${var.num_cache_nodes}"
  parameter_group_name = "${var.parameter_group_name_redis}"
  engine_version       = "${var.engine_version_redis}"
  subnet_group_name    = aws_elasticache_subnet_group.redis_subnet_group.name
  security_group_ids =  [aws_security_group.redis-sg.id]
  port                 = 6379
}

