#ecs iam role for ecs ec2 template to use the instance role
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

  //must chage this shell file when ecs cluster change 
  user_data = filebase64("./buildspec/ecs_init.sh")
}


#ecs autoscaling role

#acto_scaling for ecs ->> ec2 this autoscaling setting only relate with the ecs ec2 
resource "aws_autoscaling_group" "orjujeng_autoscaling_ecs" {
  name     = "orjujeng-autoscaling-ecs"
  max_size = 1
  min_size = 0
  # need close for saving unit
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"
  force_delete              = true
  vpc_zone_identifier       = [aws_subnet.orjujeng_inside_net_1a.id, aws_subnet.orjujeng_inside_net_1c.id]
  #service_linked_role_arn   = "arn:aws:iam::877401119357:role/aws-service-role/ecs.application-autoscaling.amazonaws.com/AWSServiceRoleForApplicationAutoScaling_ECSService"

  launch_template {
    name    = aws_launch_template.orjujeng_ecs_template.name
    version = "$Latest"
  }

  timeouts {
    delete = "15m"
  }
}