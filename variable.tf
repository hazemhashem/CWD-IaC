#*****network******#

variable "region" {
  type = string
}

variable "cidr_vpc" {
  type = string
}

variable "public_subnet_1" {
  type = string
}

variable "public_subnet_2" {
  type = string
}

variable "private_subnet_1" {
  type = string
}

variable "private_subnet_2" {
  type = string
}

variable "availability_zone_a" {
  type = string
}
variable "availability_zone_b" {
  type = string
}

#*****eks******#

variable "eks_name" {
  type = string
}

variable "node_name" {
  type = string
}

variable "ami_type" {
  type = string
}

variable "capacity_type" {
  type = string
}
variable "disk_size" {
  type = string
}

variable "instance_types" {
  type = string
}

variable "desired_size" {
  type = string
}

variable "max_size" {
  type = string
}

variable "min_size" {
  type = string
}

#********rds************#

variable "allocated_storage" {
  type = string
}
variable "db_name" {
  type = string
}
variable "engine" {
  type = string
}
variable "engine_version" {
  type = string
}
variable "instance_class" {
  type = string
}
variable "username" {
  type = string
}
variable "password" {
  type = string
}
variable "parameter_group_name" {
  type = string
}
variable "skip_final_snapshot" {
  type = string
}

# *********** redis *********** #
variable "cluster_id" {
  type = string
}
variable "engine_redis" {
  type = string
}
variable "node_type" {
  type = string
}
variable "num_cache_nodes" {
  type = string
}
variable "parameter_group_name_redis" {
  type = string
}
variable "engine_version_redis" {
  type = string
}
variable "account_id" {
  type = string
}
