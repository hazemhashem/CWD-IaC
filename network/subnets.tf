resource "aws_subnet" "Public_Subnet_1" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnet_1
  availability_zone       = var.availability_zone_a
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_1"
  }
}


resource "aws_subnet" "Public_Subnet_2" {
  vpc_id                  = aws_vpc.myVPC.id
  cidr_block              = var.public_subnet_2
  availability_zone       = var.availability_zone_b
  map_public_ip_on_launch = true
  tags = {
    Name = "Public_Subnet_2"
  }
}



# Private Subnet
resource "aws_subnet" "Private_Subnet_1" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.private_subnet_1
  availability_zone = var.availability_zone_a
  tags = {
    Name = "Public_Subnet_1"
  }
}

resource "aws_subnet" "Private_Subnet_2" {
  vpc_id            = aws_vpc.myVPC.id
  cidr_block        = var.private_subnet_2
  availability_zone = var.availability_zone_b
  tags = {
    Name = "Public_Subnet_2"
  }
}