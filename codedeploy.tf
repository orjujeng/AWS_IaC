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

#codedeploy app
resource "aws_codedeploy_app" "orjujeng_codedeploy_poc_app" {
  compute_platform = "Server"
  name = "orjujeng_codedeploy_poc_app"
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

  outdated_instances_strategy = "UPDATE"

}


##ec2 codedeploy script
#sudo yum install ruby -y && sudo cd /home/ec2-user && sudo wget https://aws-codedeploy-ap-northeast-1.s3.ap-northeast-1.amazonaws.com/latest/install&&sudo chmod +x ./install&&sudo ./install auto


