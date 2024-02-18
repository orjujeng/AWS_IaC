#lb
resource "aws_alb" "orjujeng_lb" {
  name               = "orjujeng-lb"
  internal           = false
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
    target_group_arn = aws_lb_target_group.orjujeng_service_target_group.arn
  }
}

## Target Group for our service
resource "aws_lb_target_group" "orjujeng_service_target_group" {
  name                 = "orjujeng-service-target-group"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  # need setting when use th api
  # health_check {
  #   healthy_threshold   = "2"
  #   unhealthy_threshold = "2"
  #   interval            = "60"
  #   matcher             = var.healthcheck_matcher
  #   path                = var.healthcheck_endpoint
  #   port                = "traffic-port"
  #   protocol            = "HTTP"
  #   timeout             = "30"
  # }
  depends_on = [aws_alb.orjujeng_lb]
}

resource "aws_lb_target_group" "orjujeng_service_target_group_b" {
  name                 = "orjujeng-service-target-group-b"
  port                 = "80"
  protocol             = "HTTP"
  vpc_id               = aws_vpc.orjujeng_vpc.id
  deregistration_delay = 120
  # need setting when use th api
  # health_check {
  #   healthy_threshold   = "2"
  #   unhealthy_threshold = "2"
  #   interval            = "60"
  #   matcher             = var.healthcheck_matcher
  #   path                = var.healthcheck_endpoint
  #   port                = "traffic-port"
  #   protocol            = "HTTP"
  #   timeout             = "30"
  # }
  depends_on = [aws_alb.orjujeng_lb]
}
