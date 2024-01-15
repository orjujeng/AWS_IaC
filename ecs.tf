#ecs cluster
resource "aws_ecs_cluster" "orjujeng_ecs_cluster" {
  name = "orjujeng-ecs-cluster"
  setting {
    name  = "containerInsights"
    value = "disabled"
  }
  tags = {
    name = "orjujeng-ecs-cluster"
  }
}

#autoscaling provider
resource "aws_ecs_cluster_capacity_providers" "orjujeng_ecs_provider_attach" {
  cluster_name = aws_ecs_cluster.orjujeng_ecs_cluster.name

  capacity_providers = [aws_ecs_capacity_provider.orjujeng_ecs_provider.name]
}

resource "aws_ecs_capacity_provider" "orjujeng_ecs_provider" {
  name = "orjujeng_ecs_provider"

  auto_scaling_group_provider {

    auto_scaling_group_arn = aws_autoscaling_group.orjujeng_autoscaling_ecs.arn

    managed_scaling {
      maximum_scaling_step_size = 5
      minimum_scaling_step_size = 1
      status                    = "ENABLED"
      target_capacity           = 60
    }
  }
}

# ecs service role
resource "aws_iam_role" "orjujeng_ecs_service_role" {
  name               = "orjujeng_ecs_service_role"
  assume_role_policy = data.aws_iam_policy_document.orjujeng_ecs_assumerole.json
}

data "aws_iam_policy_document" "orjujeng_ecs_assumerole" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com", ]
    }
  }
}

resource "aws_iam_role_policy" "orjujeng_ecs_service_policy" {
  name   = "orjujeng_ecs_service_policy"
  policy = data.aws_iam_policy_document.orjujeng_ecs_service_role_policy.json
  role   = aws_iam_role.orjujeng_ecs_service_role.id
}


data "aws_iam_policy_document" "orjujeng_ecs_service_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:Describe*",
      "elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
      "elasticloadbalancing:DeregisterTargets",
      "elasticloadbalancing:Describe*",
      "elasticloadbalancing:RegisterInstancesWithLoadBalancer",
      "elasticloadbalancing:RegisterTargets",
      "ec2:DescribeTags",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:DescribeLogStreams",
      "logs:PutSubscriptionFilter",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

## IAM Role for ECS Task execution and ecs task role
resource "aws_iam_role" "orjujeng_ecs_task_execution_role" {
  name               = "orjujeng_ecs_task_execution_role"
  assume_role_policy = data.aws_iam_policy_document.orjujeng_task_assume_role_policy.json
}

data "aws_iam_policy_document" "orjujeng_task_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "orjujeng_ecs_task_execution_role_policy" {
  role       = aws_iam_role.orjujeng_ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "orjujeng_ecs_task_iam_role" {
  name               = "orjujeng_ecs_task_iam_role"
  assume_role_policy = data.aws_iam_policy_document.orjujeng_task_assume_role_policy.json
}

# ecs task definition
resource "aws_ecs_task_definition" "orjujeng_ecs_task_definition" {
  family             = "orjujeng-ecs-task-definition"
  execution_role_arn = aws_iam_role.orjujeng_ecs_task_execution_role.arn
  task_role_arn      = aws_iam_role.orjujeng_ecs_task_iam_role.arn
  container_definitions = jsonencode([
    {
      name      = "orjujeng-ecs-service-name"
      image     = "public.ecr.aws/nginx/nginx:stable-perl"
      cpu       = 256
      memory    = 512
      essential = true
      # requiresCompatibilities = "EC2"
      # networkMode             = "awsvpc"
      # operatingSystemFamily   = "LINUX"
      portMappings = [
        {
          name          = "nginx"
          containerPort = 80
          hostPort      = 80
          protocol      = "tcp"
          appProtocol   = "http"
        }
      ]
    }
  ])
  #   cpu    = 256
  #   memory = 512
}

## Creates ECS Service
resource "aws_ecs_service" "orjujeng_service" {
  name            = "orjujeng_service"
  iam_role        = aws_iam_role.orjujeng_ecs_service_role.arn
  cluster         = aws_ecs_cluster.orjujeng_ecs_cluster.id
  task_definition = aws_ecs_task_definition.orjujeng_ecs_task_definition.arn
  desired_count   = 1
  # deployment_minimum_healthy_percent = var.ecs_task_deployment_minimum_healthy_percent
  # deployment_maximum_percent         = var.ecs_task_deployment_maximum_percent
  load_balancer {
    target_group_arn = aws_alb_target_group.orjujeng_service_target_group.arn
    container_name   = "orjujeng-ecs-service-name"
    container_port   = "80"
  }
  # ## Spread tasks evenly accross all Availability Zones for High Availability
  # ordered_placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }
  # ## Make use of all available space on the Container Instances
  # ordered_placement_strategy {
  #   type  = "binpack"
  #   field = "memory"
  # } 
  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count]
  }
}
#https://nexgeneerz.io/aws-computing-with-ecs-ec2-terraform/#Autoscaling_on_ECS