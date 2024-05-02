resource "aws_security_group" "rds-sg" {
  name        = "allow 3306"
  vpc_id      = var.vpc_id

  ingress {
    description = "3306 from everywhere"
    from_port   = 3306
    to_port     = 3306
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
    Name = "rds-sg"
  }
}