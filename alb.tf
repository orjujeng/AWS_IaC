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

#lb
resource "aws_lb" "orjujeng_lb" {
  name               = "orjujeng-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.orjujeng_lb_sg.id]
  subnets            = [aws_subnet.orjujeng_inside_net_1a.id, aws_subnet.orjujeng_inside_net_1c.id]

  enable_deletion_protection = false

  tags = {
    Name = "orjujeng_lb"
  }
}

#attach lb and target group
resource "aws_lb_listener" "orjujeng_lb_lg" {
  load_balancer_arn = aws_lb.orjujeng_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.orjujeng_target_group.arn
  }
}
