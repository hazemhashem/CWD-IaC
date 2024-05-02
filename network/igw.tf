resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myVPC.id

  tags = {
    Name = "CWD_igw"
  }
}