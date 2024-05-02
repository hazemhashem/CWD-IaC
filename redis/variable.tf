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


variable "private_subnet_id_1" {
  type = string
}

variable "private_subnet_id_2" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "vpc_cidr" {
  type = string
}