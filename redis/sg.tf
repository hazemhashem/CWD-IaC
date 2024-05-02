resource "aws_security_group" "redis-sg" {
  name        = "allow 6379"
  vpc_id      = var.vpc_id

  ingress {
    description = "6379 from everywhere"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "redis-sg"
  }
}