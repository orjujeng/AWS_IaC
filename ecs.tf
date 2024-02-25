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


resource "aws_iam_role_policy" "orjujeng_ecs_task_execution_policy" {
  name   = "orjujeng_ecs_task_execution_policy"
  policy = data.aws_iam_policy_document.orjujeng_ecs_task_execution_policy_doc.json
  role   = aws_iam_role.orjujeng_ecs_task_execution_role.id
}

data "aws_iam_policy_document" "orjujeng_ecs_task_execution_policy_doc" {
  statement {
    effect  = "Allow"
    actions = [
      "secretsmanager:GetSecretValue",
      "ssm:GetParameters",
      "kms:Decrypt"
    ]
    resources = ["*"]
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
resource "aws_ecs_task_definition" "orjujeng_auth_api_ecs_task_definition" {
  family                = "orjujeng-auth-api-ecs-task-definition"
  execution_role_arn    = aws_iam_role.orjujeng_ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.orjujeng_ecs_task_iam_role.arn
  container_definitions = templatefile("./buildspec/auth_api_ecs_task_def.json", {})
  network_mode          = "bridge"
  #   cpu    = 256
  #   memory = 512
}

resource "aws_ecs_task_definition" "orjujeng_manager_api_ecs_task_definition" {
  family                = "orjujeng-manager-api-ecs-task-definition"
  execution_role_arn    = aws_iam_role.orjujeng_ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.orjujeng_ecs_task_iam_role.arn
  container_definitions = templatefile("./buildspec/manager_api_ecs_task_def.json", {})
  network_mode          = "bridge"
  #   cpu    = 256
  #   memory = 512
}

resource "aws_ecs_task_definition" "orjujeng_profile_api_ecs_task_definition" {
  family                = "orjujeng-profile-api-ecs-task-definition"
  execution_role_arn    = aws_iam_role.orjujeng_ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.orjujeng_ecs_task_iam_role.arn
  container_definitions = templatefile("./buildspec/profile_api_ecs_task_def.json", {})
  network_mode          = "bridge"
  #   cpu    = 256
  #   memory = 512
}

resource "aws_ecs_task_definition" "orjujeng_request_api_ecs_task_definition" {
  family                = "orjujeng-request-api-ecs-task-definition"
  execution_role_arn    = aws_iam_role.orjujeng_ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.orjujeng_ecs_task_iam_role.arn
  container_definitions = templatefile("./buildspec/request_api_ecs_task_def.json", {})
  network_mode          = "bridge"
  #   cpu    = 256
  #   memory = 512
}

resource "aws_ecs_task_definition" "orjujeng_timesheet_api_ecs_task_definition" {
  family                = "orjujeng-timesheet-api-ecs-task-definition"
  execution_role_arn    = aws_iam_role.orjujeng_ecs_task_execution_role.arn
  task_role_arn         = aws_iam_role.orjujeng_ecs_task_iam_role.arn
  container_definitions = templatefile("./buildspec/timesheet_api_ecs_task_def.json", {})
  network_mode          = "bridge"
  #   cpu    = 256
  #   memory = 512
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

resource "aws_iam_role_policy_attachment" "attach_AmazonEC2ContainerServiceRole" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
  role       = aws_iam_role.orjujeng_ecs_service_role.name
}

# Creates ECS Service
resource "aws_ecs_service" "orjujeng_manager_api_service" {
  name     = "orjujeng_manager_api_service"
  iam_role = aws_iam_role.orjujeng_ecs_service_role.arn
  cluster  = aws_ecs_cluster.orjujeng_ecs_cluster.id
  task_definition = aws_ecs_task_definition.orjujeng_manager_api_ecs_task_definition.arn
  #need close
  desired_count                      = 1
  deployment_minimum_healthy_percent = 0
  deployment_maximum_percent         = 200

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orjujeng_manager_api_target_group.arn
    container_name   = "th-manager-api"
    container_port   = "8080"
  }
  deployment_controller {
    type = "CODE_DEPLOY"
  }
  # ## Spread tasks evenly accross all Availability Zones for High Availability
  # ordered_placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }
  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }
}
#https://nexgeneerz.io/aws-computing-with-ecs-ec2-terraform/#Autoscaling_on_ECS

#https://www.bilibili.com/video/BV1nR4y1N72u?p=40&vd_source=777b66d9ea6bb56ea53f120df4b32bb6


#ecs autoscaling 
resource "aws_appautoscaling_target" "orjujeng_ecs_target" {
  max_capacity       = 2
  min_capacity       = 0
  resource_id        = "service/${aws_ecs_cluster.orjujeng_ecs_cluster.name}/${aws_ecs_service.orjujeng_manager_api_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

## Policy for CPU tracking
resource "aws_appautoscaling_policy" "orjujeng_ecs_cpu_policy" {
  name               = "orjujeng_ecs_CPUTarget_tracking_scaling"
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.orjujeng_ecs_target.resource_id
  scalable_dimension = aws_appautoscaling_target.orjujeng_ecs_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.orjujeng_ecs_target.service_namespace

  target_tracking_scaling_policy_configuration {
    target_value = 85

    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }
  }
}



resource "aws_ecs_service" "orjujeng_auth_api_service" {
  name     = "orjujeng_auth_api_service"
  iam_role = aws_iam_role.orjujeng_ecs_service_role.arn
  cluster  = aws_ecs_cluster.orjujeng_ecs_cluster.id
  task_definition = aws_ecs_task_definition.orjujeng_auth_api_ecs_task_definition.arn
  #need close
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 150

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orjujeng_authapi_tg.arn
    container_name   = "th-auth-api"
    container_port   = "8080"
  }
  # deployment_controller {
  #   type = "CODE_DEPLOY"
  # }
  # ## Spread tasks evenly accross all Availability Zones for High Availability
  # ordered_placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }
  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }
}

resource "aws_ecs_service" "orjujeng_profile_api_service" {
  name     = "orjujeng_profile_api_service"
  iam_role = aws_iam_role.orjujeng_ecs_service_role.arn
  cluster  = aws_ecs_cluster.orjujeng_ecs_cluster.id
  task_definition = aws_ecs_task_definition.orjujeng_profile_api_ecs_task_definition.arn
  #need close
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 150

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orjujeng_profileapi_tg.arn
    container_name   = "th-profile-api"
    container_port   = "8080"
  }
  # deployment_controller {
  #   type = "CODE_DEPLOY"
  # }
  # ## Spread tasks evenly accross all Availability Zones for High Availability
  # ordered_placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }
  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }
}

resource "aws_ecs_service" "orjujeng_request_api_service" {
  name     = "orjujeng_request_api_service"
  iam_role = aws_iam_role.orjujeng_ecs_service_role.arn
  cluster  = aws_ecs_cluster.orjujeng_ecs_cluster.id
  task_definition = aws_ecs_task_definition.orjujeng_request_api_ecs_task_definition.arn
  #need close
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 150

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orjujeng_requestapi_tg.arn
    container_name   = "th-request-api"
    container_port   = "8080"
  }
  # deployment_controller {
  #   type = "CODE_DEPLOY"
  # }
  # ## Spread tasks evenly accross all Availability Zones for High Availability
  # ordered_placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }
  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }
}

resource "aws_ecs_service" "orjujeng_timesheet_api_service" {
  name     = "orjujeng_timesheet_api_service"
  iam_role = aws_iam_role.orjujeng_ecs_service_role.arn
  cluster  = aws_ecs_cluster.orjujeng_ecs_cluster.id
  task_definition = aws_ecs_task_definition.orjujeng_timesheet_api_ecs_task_definition.arn
  #need close
  desired_count                      = 1
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 150

  ordered_placement_strategy {
    type  = "binpack"
    field = "cpu"
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.orjujeng_timesheetapi_tg.arn
    container_name   = "th-timesheet-api"
    container_port   = "8080"
  }
  # deployment_controller {
  #   type = "CODE_DEPLOY"
  # }
  # ## Spread tasks evenly accross all Availability Zones for High Availability
  # ordered_placement_strategy {
  #   type  = "spread"
  #   field = "attribute:ecs.availability-zone"
  # }
  ## Do not update desired count again to avoid a reset to this number on every deployment
  lifecycle {
    ignore_changes = [desired_count, task_definition, load_balancer]
  }
}