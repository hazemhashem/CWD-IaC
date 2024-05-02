resource "aws_vpc" "myVPC" {
  cidr_block = var.cidr_vpc
  enable_dns_hostnames = true
    tags = {
    Name = "CWD_VPC"
  }
}