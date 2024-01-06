resource "aws_efs_file_system" "orjujeng_efs" {
  tags = {
    Name = "orjujeng_efs"
  }
}

resource "aws_efs_mount_target" "orjujeng_efs_mount_to_private_1a" {
  file_system_id  = aws_efs_file_system.orjujeng_efs.id
  subnet_id       = aws_subnet.orjujeng_private_net_1a.id
  security_groups = [aws_security_group.orjujeng_efs_sg.id]
}

resource "aws_efs_mount_target" "orjujeng_efs_mount_to_private_1c" {
  file_system_id  = aws_efs_file_system.orjujeng_efs.id
  subnet_id       = aws_subnet.orjujeng_private_net_1c.id
  security_groups = [aws_security_group.orjujeng_efs_sg.id]
}

#mount with ip address only;