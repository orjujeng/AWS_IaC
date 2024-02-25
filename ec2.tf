#get the lastest ami id (linux 2)
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn-ami-*-ecs-optimized"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
#ssh-key generated & pub key should be added in tfvar file.
#use this public key guess i can connect ec2 instance without any other key.
resource "aws_key_pair" "orjujeng_macmini_ec2_key_pair" {
  key_name   = "orjujeng_macmini_ec2_key_pair"
  public_key = var.ssh_key
  tags = {
    Name = "orjujeng_macmini_ec2_key_pair"
  }
}

#ec2 
#please keep it destory after daily work for saving cost.
# resource "aws_instance" "orjujeng-iac-test-ec2-1a" {
#   ami                         = "ami-020283e959651b381"
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.orjujeng_inside_net_1a.id
#   vpc_security_group_ids      = [aws_security_group.orjujeng_ec2_sg.id]
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.orjujeng_macmini_ec2_key_pair.key_name
#   iam_instance_profile        = aws_iam_instance_profile.orjujeng_ec2_instance_profile.name
#   user_data = <<EOF
#                  #!/bin/bash
#                  sudo yum install -y docker
#                  sudo systemctl start docker
#                  sudo usermod -aG docker ec2-user
#                  sudo CODEDEPLOY_BIN="/opt/codedeploy-agent/bin/codedeploy-agent"
#                  sudo $CODEDEPLOY_BIN stop
#                  sudo yum erase codedeploy-agent -y
#                  sudo yum install ruby -y 
#                  sudo cd /home/ec2-user 
#                  sudo wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
#                  sudo chmod +x ./install
#                  sudo ./install auto
#               EOF
#   tags = {
#     Name = "orjujeng-iac-test-ec2"
#   }
# }

# resource "aws_instance" "orjujeng-iac-test-ec2-1c" {
#   ami                         = data.aws_ami.latest-amazon-linux-image.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.orjujeng_inside_net_1c.id
#   vpc_security_group_ids      = [aws_security_group.orjujeng_ec2_sg.id]
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.orjujeng_macmini_ec2_key_pair.key_name
#   iam_instance_profile        = aws_iam_instance_profile.orjujeng_ec2_instance_profile.name
#   user_data = <<EOF
#                  #!/bin/bash
#                  sudo yum install -y docker
#                  sudo systemctl start docker
#                  sudo usermod -aG docker ec2-user
#                  sudo CODEDEPLOY_BIN="/opt/codedeploy-agent/bin/codedeploy-agent"
#                  sudo $CODEDEPLOY_BIN stop
#                  sudo yum erase codedeploy-agent -y
#                  sudo yum install ruby -y 
#                  sudo cd /home/ec2-user 
#                  sudo wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install
#                  sudo chmod +x ./install
#                  sudo ./install auto
#               EOF
#   tags = {
#     Name = "orjujeng-iac-test-ec2"
#   }
# }
