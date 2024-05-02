
variable "public_subnet_id_1" {
  type = string
}
variable "public_subnet_id_2" {
  type = string
}



variable "private_subnet_id_1" {
  type = string
}
variable "private_subnet_id_2" {
  type = string
}

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
