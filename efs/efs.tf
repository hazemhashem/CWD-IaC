resource "aws_efs_file_system" "efs" {
  creation_token   = "efs"
  tags = {
    Name = "CWD-efs"
  }
}


resource "aws_efs_mount_target" "efs_target_1" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.private_subnet_1_id
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_mount_target" "efs_target_2" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = var.private_subnet_2_id
  security_groups = [aws_security_group.efs_sg.id]
}





resource "aws_security_group" "efs_sg" {
  name        = "efs-sg"
  description = "Allows inbound efs traffic from EKS"
  vpc_id      = var.vpc_id

  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

      tags = {
    Name = "efs_sg"
  }
}
