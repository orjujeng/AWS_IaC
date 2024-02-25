#lb
resource "aws_alb" "orjujeng_lb" {
  name               = "orjujeng-lb"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [aws_security_group.orjujeng_lb_sg.id]
  subnets            = [aws_subnet.orjujeng_inside_net_1a.id, aws_subnet.orjujeng_inside_net_1c.id]

  enable_deletion_protection = false

  tags = {
    Name = "orjujeng_alb"
  }
}

#####for ec2 only 
# target group 
resource "aws_lb_target_group" "orjujeng_target_group" {
  name        = "orjujeng-target-group"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = aws_vpc.orjujeng_vpc.id
  target_type = "instance"
  tags = {
    Name = "orjujeng_target_group"
  }
}

#attach lb and target group
# resource "aws_lb_listener" "orjujeng_lb_lg" {
#   load_balancer_arn = aws_lb.orjujeng_lb.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.orjujeng_target_group.arn
#   }
# }



#####for ecs only 
## Default HTTPS listener that blocks all traffic without valid custom origin header
resource "aws_alb_listener" "orjujeng_alb_ecs_listener" {
  load_balancer_arn = aws_alb.orjujeng_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orjujeng_manager_api_target_group.arn
  }
}

resource "aws_lb_listener_rule" "orjujeng_authapi_rule" {
  listener_arn = aws_alb_listener.orjujeng_alb_ecs_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orjujeng_authapi_tg.arn
  }

  condition {
    path_pattern {
      values = ["/auth/*"]
    }
  }
}

resource "aws_lb_listener_rule" "orjujeng_profileapi_rule" {
  listener_arn = aws_alb_listener.orjujeng_alb_ecs_listener.arn
 

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orjujeng_profileapi_tg.arn
  }

  condition {
    path_pattern {
      values = ["/profile/*"]
    }
  }
}


resource "aws_lb_listener_rule" "orjujeng_timesheetapi_rule" {
  listener_arn = aws_alb_listener.orjujeng_alb_ecs_listener.arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orjujeng_timesheetapi_tg.arn
  }

  condition {
    path_pattern {
      values = ["/timesheet/*"]
    }
  }
}

resource "aws_lb_listener_rule" "orjujeng_requestapi_rule" {
  listener_arn = aws_alb_listener.orjujeng_alb_ecs_listener.arn
  

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orjujeng_requestapi_tg.arn
  }

  condition {
    path_pattern {
      values = ["/request/*"]
    }
  }
}

resource "aws_lb_target_group" "orjujeng_authapi_tg" {
  name                 = "orjujeng-authapi-tg"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  # need setting when use th api
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "300"
    matcher             = "200-499"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
  depends_on = [aws_alb.orjujeng_lb]
}

resource "aws_lb_target_group" "orjujeng_timesheetapi_tg" {
  name                 = "orjujeng-timesheetapi-tg"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  # need setting when use th api
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "300"
    matcher             = "200-499"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
  depends_on = [aws_alb.orjujeng_lb]
}

resource "aws_lb_target_group" "orjujeng_profileapi_tg" {
  name                 = "orjujeng-profileapi-tg"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "300"
    matcher             = "200-499"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
  depends_on = [aws_alb.orjujeng_lb]
}

resource "aws_lb_target_group" "orjujeng_requestapi_tg" {
  name                 = "orjujeng-requestapi-tg"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "300"
    matcher             = "200-499"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
  depends_on = [aws_alb.orjujeng_lb]
}

## Target Group for our service
resource "aws_lb_target_group" "orjujeng_manager_api_target_group" {
  name                 = "orjujeng-managerapi-tg"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "300"
    matcher             = "200-499"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
  depends_on = [aws_alb.orjujeng_lb]
}

resource "aws_lb_target_group" "orjujeng_manager_api_target_group_b" {
  name                 = "orjujeng-manager-api-tg-b"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
 health_check {
    healthy_threshold   = "5"
    unhealthy_threshold = "2"
    interval            = "300"
    matcher             = "200-499"
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "30"
  }
  depends_on = [aws_alb.orjujeng_lb]
}
