#******* Network *********** #

module "network" {
  source   = "./network"
  cidr_vpc = var.cidr_vpc

  public_subnet_1 = var.public_subnet_1
  public_subnet_2 = var.public_subnet_2

  private_subnet_1 = var.private_subnet_1
  private_subnet_2 = var.private_subnet_2

  availability_zone_a = var.availability_zone_a
  availability_zone_b = var.availability_zone_b
}


#********* EKS_Cluster ************#
module "eks" {
  source     = "./eks"
  account_id = var.account_id
  region     = var.region
  eks_name   = var.eks_name

  public_subnet_id_1 = module.network.public_subnet_id_1
  public_subnet_id_2 = module.network.public_subnet_id_2

  private_subnet_id_1 = module.network.private_subnet_id_1
  private_subnet_id_2 = module.network.private_subnet_id_2
}


#********* Node_Group ************#
module "node_group" {
  source = "./worker_node"

  eks_name = module.eks.eks_name

  public_subnet_id_1 = module.network.public_subnet_id_1
  public_subnet_id_2 = module.network.public_subnet_id_2

  private_subnet_id_1 = module.network.private_subnet_id_1
  private_subnet_id_2 = module.network.private_subnet_id_2


  node_name      = var.node_name
  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = var.instance_types
  desired_size   = var.desired_size
  max_size       = var.max_size
  min_size       = var.min_size


}

#******* rds *********** #
module "rds" {
  source               = "./rds"
  allocated_storage    = var.allocated_storage
  db_name              = var.db_name
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  username             = var.username
  password             = var.password
  parameter_group_name = var.parameter_group_name
  skip_final_snapshot  = var.skip_final_snapshot

  vpc_id              = module.network.vpc_id
  vpc_cidr            = var.cidr_vpc
  private_subnet_id_1 = module.network.private_subnet_id_1
  private_subnet_id_2 = module.network.private_subnet_id_2
}
#******* Redis *********** #
module "redis" {
  source                     = "./redis"
  cluster_id                 = var.cluster_id
  engine_redis               = var.engine_redis
  node_type                  = var.node_type
  num_cache_nodes            = var.num_cache_nodes
  parameter_group_name_redis = var.parameter_group_name_redis
  engine_version_redis       = var.engine_version_redis


  vpc_id              = module.network.vpc_id
  vpc_cidr            = var.cidr_vpc
  private_subnet_id_1 = module.network.private_subnet_id_1
  private_subnet_id_2 = module.network.private_subnet_id_2
}
#******* secret_manger *********** #
module "secret_manger" {
  source       = "./secret_manger"
  RDS_HOSTNAME = module.rds.rds_hostname
  db_name      = module.rds.rds_name
  RDS_USERNAME = var.username
  RDS_PASSWORD = module.rds.rds_password
  RDS_PORT     = module.rds.rds_port

  REDIS_HOSTNAME = module.redis.redis_host
  REDIS_PORT     = module.redis.redis_port
  account_id     = var.account_id
  OIDC_URL       = module.eks.OIDC_URL
  region         = var.region
}


#******* Helm *********** #

module "Helm" {
  source      = "./helm"
  eks_cluster = module.eks.eks_name
}

#******* EFS *********** #

module "efs" {

  source              = "./efs"
  private_subnet_1_id = module.network.private_subnet_id_1
  private_subnet_2_id = module.network.private_subnet_id_2
  cluster_id          = module.eks.eks_name
  vpc_id              = module.network.vpc_id
  vpc_cidr            = var.cidr_vpc
  region              = var.region
  OIDC_URL            = module.eks.OIDC_URL
  account_id          = var.account_id
  OIDC_ARN            = module.eks.OIDC_ARN
}











