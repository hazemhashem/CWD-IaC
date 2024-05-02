resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.Public_Subnet_1.id

  tags = {
    Name = "CWD_nat_gw"
  }
}