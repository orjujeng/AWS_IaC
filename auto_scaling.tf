#ec2 template
resource "aws_launch_template" "orjujeng_ec2_template" {
  name = "orjujeng-ec2-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.orjujeng_ec2_instance_profile.name
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.orjujeng_ec2_sg.id]
  }
  image_id = data.aws_ami.latest-amazon-linux-image.id
  #   vpc_security_group_ids               = [aws_security_group.orjujeng_ec2_sg.id]
  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "orjujeng-iac-test-ec2"
    }
  }
  tags = {
    Name = "orjujeng-ec2-template"
  }
  user_data = filebase64("./buildspec/ec2_init.sh")
}
#acto_scaling
resource "aws_autoscaling_group" "orjujeng_autoscaling" {
  name                      = "orjujeng-autoscaling"
  max_size                  = 1
  min_size                  = 0
  desired_capacity          = 0
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.orjujeng_inside_net_1a.id, aws_subnet.orjujeng_inside_net_1c.id]

  launch_template {
    name    = aws_launch_template.orjujeng_ec2_template.name
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.orjujeng_target_group.arn]

  tag {
    key                 = "Name"
    value               = "orjujeng-iac-test-ec2"
    propagate_at_launch = true
  }

  timeouts {
    delete = "15m"
  }
}


##for delete instance profile

#aws iam delete-instance-profile --instance-profile-name=orjujeng_ecs_instance_profile


##https://github.com/terraform-aws-modules/terraform-aws-ecs/tree/master/modules/cluster
#new role for ecs