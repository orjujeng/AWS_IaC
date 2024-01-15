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
  max_size                  = 0
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

data "aws_iam_policy_document" "orjujneg_ecs_instance_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "ecs.amazonaws.com"
      ]
    }
  }
}
resource "aws_iam_role" "orjujeng_ecs_iam_role" {
  name               = "orjujeng_ecs_iam_role"
  assume_role_policy = data.aws_iam_policy_document.orjujneg_ecs_instance_role_policy.json
}

data "aws_iam_policy" "AmazonEC2ContainerServiceforEC2Role" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "attach_AmazonEC2ContainerServiceforEC2Role" {
  role       = aws_iam_role.orjujeng_ecs_iam_role.name
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerServiceforEC2Role.arn
}

#attach ecsInstanceRole role
resource "aws_iam_instance_profile" "orjujeng_ecs_instance_profile" {
  name = "orjujeng_ecs_instance_profile"
  role = aws_iam_role.orjujeng_ecs_iam_role.name
}

#ecs ec2 template 
resource "aws_launch_template" "orjujeng_ecs_template" {
  name = "orjujeng-ecs-template"

  iam_instance_profile {
    name = aws_iam_instance_profile.orjujeng_ecs_instance_profile.name
  }
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.orjujeng_ec2_sg.id]
  }
  image_id = data.aws_ami.latest-amazon-linux-image.id
    # vpc_security_group_ids               = [aws_security_group.orjujeng_ec2_sg.id]
  instance_initiated_shutdown_behavior = "terminate"

  instance_type = "t2.micro"
  key_name      = aws_key_pair.orjujeng_macmini_ec2_key_pair.key_name
  tags = {
    Name = "orjujeng-ecs-template"
  }

  # block_device_mappings {
  #   device_name = "/dev/xvda"

  #   ebs {
  #     volume_size = 30
  #   }
  # }
  user_data = filebase64("./buildspec/ecs_init.sh")
}

#acto_scaling for ecs ec2
resource "aws_autoscaling_group" "orjujeng_autoscaling_ecs" {
  name                      = "orjujeng-autoscaling-ecs"
  max_size                  = 1
  min_size                  = 0
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.orjujeng_inside_net_1a.id, aws_subnet.orjujeng_inside_net_1c.id]

  launch_template {
    name    = aws_launch_template.orjujeng_ecs_template.name
    version = "$Latest"
  }

  timeouts {
    delete = "15m"
  }
}