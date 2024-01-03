#rds subnet group 
resource "aws_db_subnet_group" "orjujeng_rds_subnet_group" {
  name       = "orjujeng_rds_subnet_group"
  subnet_ids = [aws_subnet.orjujeng_private_net_1a.id, aws_subnet.orjujeng_private_net_1c.id]

  tags = {
    Name = "orjujeng_rds_subnet_group"
  }
}
# resource "aws_db_instance" "orjujeng_mysql_rds" {
#   allocated_storage       = 10
#   availability_zone       = var.availability_zone_1a
#   backup_retention_period = 7
#   db_subnet_group_name    = aws_db_subnet_group.orjujeng_rds_subnet_group.name
#   engine                  = "mysql"
#   engine_version          = "5.7"
#   instance_class          = "db.t3.micro"
#   username                = "root"
#   password                = "root12345678"
#   port                    = 3306
#   vpc_security_group_ids  = [aws_security_group.orjujeng_rds_sg.id]
#   multi_az                = false
#   skip_final_snapshot     = true
#   tags = {
#     name : "orjujeng_mysql_rds"
#   }
# }

#if you wanna contect the rds via ec2 please reference https://docs.aws.amazon.com/zh_cn/AmazonRDS/latest/UserGuide/CHAP_GettingStarted.CreatingConnecting.MySQL.html#CHAP_GettingStarted.Connecting.MySQL