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