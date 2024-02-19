resource "aws_sns_topic" "orjujeng_sns_topic" {
  name = "orjujeng_sns_topic"
}

resource "aws_sns_topic_subscription" "orjujeng_sns_topic_subscription" {
  topic_arn = aws_sns_topic.orjujeng_sns_topic.arn
  protocol  = "email"
  endpoint  = "orjujeng@hotmail.com"
}

resource "aws_sns_topic_subscription" "orjujeng_sns_topic_subscription" {
  topic_arn = aws_sns_topic.orjujeng_sns_topic.arn
  protocol  = "email"
  endpoint  = "orjujeng@gmail.com"
}