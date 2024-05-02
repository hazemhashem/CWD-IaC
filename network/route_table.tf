resource "aws_route_table" "public" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = "Public_route"
  }
}



resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id

}

resource "aws_route_table_association" "public_subnet_1" {
  subnet_id      = aws_subnet.Public_Subnet_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_subnet_2" {
  subnet_id      = aws_subnet.Public_Subnet_2.id
  route_table_id = aws_route_table.public.id
}

# private routing

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.myVPC.id
  tags = {
    Name = "private_route"
  }
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gw.id

}

resource "aws_route_table_association" "private_subnet_1" {
  subnet_id      = aws_subnet.Private_Subnet_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_subnet_2" {
  subnet_id      = aws_subnet.Private_Subnet_2.id
  route_table_id = aws_route_table.private.id
}