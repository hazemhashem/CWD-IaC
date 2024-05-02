resource "aws_eip" "eip" {
  tags = {
    Name = "CWD-eip"
  }
}
