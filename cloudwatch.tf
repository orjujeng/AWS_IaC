# resource "aws_cloudwatch_metric_alarm" "orjujeng_ecs_service_cpu_usage_alarm" {
#   alarm_name                = "orjujeng_ecs_service_cpu_usage_alarm"
#   comparison_operator       = "GreaterThanOrEqualToThreshold"
#   evaluation_periods        = 1
#   metric_name               = "MemoryUtilization"
#   namespace                 = "AWS/ECS"
#   period                    = 120
#   statistic                 = "Average"
#   threshold                 = 220
#   alarm_actions             = [aws_sns_topic.orjujeng_sns_topic.arn]
#   alarm_description         = "This metric monitors ecs cpu utilization"
#   insufficient_data_actions = []
#   dimensions = {
#     ClusterName=aws_ecs_cluster.orjujeng_ecs_cluster.name
#     ServiceName=aws_ecs_service.orjujeng_service.name
#   }
# }