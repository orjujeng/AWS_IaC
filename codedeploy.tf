#codedeploy assumerole
data "aws_iam_policy_document" "assume_role_to_codedeploy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codedeploy.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "orjuneng_codedeploy_role" {
  name               = "orjuneng_codedeploy_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_to_codedeploy.json
}

resource "aws_iam_role_policy_attachment" "AWSCodeDeployRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
  role       = aws_iam_role.orjuneng_codedeploy_role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
  role       = aws_iam_role.orjuneng_codedeploy_role.name
}

#codedeploy app
resource "aws_codedeploy_app" "orjujeng_codedeploy_poc_app" {
  compute_platform = "Server"
  name             = "orjujeng_codedeploy_poc_app"
}

#codedeploy group 
resource "aws_codedeploy_deployment_group" "orjujeng_codedeploy_poc_group" {
  app_name              = aws_codedeploy_app.orjujeng_codedeploy_poc_app.name
  deployment_group_name = "orjujeng_codedeploy_poc_group"
  service_role_arn      = aws_iam_role.orjuneng_codedeploy_role.arn

  ec2_tag_set {
    ec2_tag_filter {
      key   = "Name"
      type  = "KEY_AND_VALUE"
      value = "orjujeng-iac-test-ec2"
    }
  }
  load_balancer_info {
    target_group_info {
      name = aws_lb_target_group.orjujeng_target_group.name
    }
  }
  deployment_config_name      = "CodeDeployDefault.AllAtOnce"
  autoscaling_groups          = [aws_autoscaling_group.orjujeng_autoscaling.id]
  outdated_instances_strategy = "UPDATE"

}


##ec2 codedeploy script
#sudo yum install ruby -y && sudo cd /home/ec2-user && sudo wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install&&sudo chmod +x ./install&&sudo ./install auto


# resource "aws_codedeploy_deployment_group" "orjujeng_codedeploy_ecs_group" {
#   app_name              = aws_codedeploy_app.orjujeng_codedeploy_ecs_app.name
#   deployment_group_name = "orjujeng_codedeploy_ecs_app"
#   service_role_arn      = aws_iam_role.orjuneng_codedeploy_role.arn



#   blue_green_deployment_config {

#     deployment_ready_option {
#       action_on_timeout = "CONTINUE_DEPLOYMENT"
#     }

#     terminate_blue_instances_on_deployment_success {
#       action                           = "TERMINATE"
#       termination_wait_time_in_minutes = 5
#     }

#   }

#   ecs_service {
#     cluster_name = aws_ecs_cluster.orjujeng_ecs_cluster.name
#     service_name = aws_ecs_service.orjujeng_service.name
#   }
#   deployment_style {
#     deployment_option = "WITH_TRAFFIC_CONTROL"
#     deployment_type   = "BLUE_GREEN"
#   }
#   load_balancer_info {
#     target_group_pair_info {
#       prod_traffic_route {
#         listener_arns = [aws_alb_listener.orjujeng_alb_default_listener_https.arn]
#       }
#       target_group {
#         name = aws_alb_target_group.orjujeng_service_target_group.name
#       }
#     }
#   }

#   deployment_config_name = "CodeDeployDefault.AllAtOnce"

# }

#codedeploy app
resource "aws_codedeploy_app" "orjujeng_codedeploy_ecs_app" {
  compute_platform = "ECS"
  name             = "orjujeng_codedeploy_ecs_app"
}