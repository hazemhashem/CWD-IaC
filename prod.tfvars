region = "us-east-1"


cidr_vpc         = "10.0.0.0/16"
public_subnet_1  = "10.0.1.0/24"
public_subnet_2  = "10.0.2.0/24"
private_subnet_1 = "10.0.3.0/24"
private_subnet_2 = "10.0.4.0/24"


availability_zone_a = "us-east-1a"
availability_zone_b = "us-east-1b"


eks_name = "cwd_eks"

#***** Node_group ******#
node_name      = "private_node"
ami_type       = "AL2_x86_64"
capacity_type  = "ON_DEMAND"
disk_size      = "20"
instance_types = "t3.small"
desired_size   = 1
max_size       = 4
min_size       = 0

#************** RDS ************#
  allocated_storage    = 10
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "admin12345678"
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

#************** redis ************#
  cluster_id           = "cluster-redis"
  engine_redis               = "redis"
  node_type            = "cache.t3.micro"
  num_cache_nodes      = 1
  parameter_group_name_redis = "default.redis7"
  engine_version_redis       = "7.1"
