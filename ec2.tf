#get the lastest ami id (linux 2)
data "aws_ami" "latest-amazon-linux-image" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
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
# resource "aws_instance" "orjujeng-iac-test-ec2" {
#   ami                         = data.aws_ami.latest-amazon-linux-image.id
#   instance_type               = "t2.micro"
#   subnet_id                   = aws_subnet.orjujeng_inside_net_1a.id
#   vpc_security_group_ids      = [aws_security_group.orjujeng_ec2_sg.id]
#   associate_public_ip_address = true
#   key_name                    = aws_key_pair.orjujeng_macmini_ec2_key_pair.key_name
#   iam_instance_profile        = aws_iam_instance_profile.orjujeng_ec2_instance_profile.name
#   tags = {
#     Name = "orjujeng-iac-test-ec2"
#   }
# }
