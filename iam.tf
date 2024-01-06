#you should add the new role desc data first.
data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

#create the new role
resource "aws_iam_role" "orjujeng_ec2_iam_role" {
  name               = "orjujeng_ec2_iam_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

#get the policy gov by aws
data "aws_iam_policy" "AmazonDynamoDBFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

data "aws_iam_policy" "AmazonS3FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "AmazonSSMFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

# data "aws_iam_policy" "AWSCodeCommitFullAccess" {
#   arn = "arn:aws:iam::aws:policy/AWSCodeCommitFullAccess"
# }

#attach role and policy
resource "aws_iam_role_policy_attachment" "attach_DynamoDBFullAccess" {
  role       = aws_iam_role.orjujeng_ec2_iam_role.name
  policy_arn = data.aws_iam_policy.AmazonDynamoDBFullAccess.arn
}

resource "aws_iam_role_policy_attachment" "attach_SSMFullAccess" {
  role       = aws_iam_role.orjujeng_ec2_iam_role.name
  policy_arn = data.aws_iam_policy.AmazonSSMFullAccess.arn
}

# resource "aws_iam_role_policy_attachment" "attach_CodeCommitFullAccess" {
#   role       = aws_iam_role.orjujeng_ec2_iam_role.name
#   policy_arn = data.aws_iam_policy.AWSCodeCommitFullAccess.arn
# }
#if this role need be used by aws service such as ec2 etc. you must add below resouce, this is a binding way to role and specific service if you create role via console it will generated automatic
resource "aws_iam_instance_profile" "orjujeng_ec2_instance_profile" {
  name = "orjujeng_ec2_instance_profile"
  role = aws_iam_role.orjujeng_ec2_iam_role.name
}