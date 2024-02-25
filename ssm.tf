resource "aws_ssm_parameter" "orjujeng_ssm_lb_dns" {
  name        = "orjujeng_ssm_lb_dns"
  description = "The parameter lb"
  type        = "String"
  value       = aws_alb.orjujeng_lb.dns_name

  tags = {
    environment = "orjujeng_ssm_lb_dns"
  }
}