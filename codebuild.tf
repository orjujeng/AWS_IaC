#new policy assume role
data "aws_iam_policy_document" "assume_role_codebuild" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "orjujeng_codebuild_role" {
  name               = "orjujeng_codebuild_role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_codebuild.json
}

data "aws_iam_policy" "AmazonEC2ContainerRegistryFullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}
data "aws_iam_policy" "AmazonEC2FullAccess" {
  arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}
data "aws_iam_policy" "AWSCodeBuildDeveloperAccess" {
  arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}
data "aws_iam_policy" "AWSCodePipeline_FullAccess" {
  arn = "arn:aws:iam::aws:policy/AWSCodePipeline_FullAccess"
}
data "aws_iam_policy" "CloudWatchFullAccess" {
  arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_CloudWatchFullAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.CloudWatchFullAccess.arn
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_AWSCodePipeline_FullAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.AWSCodePipeline_FullAccess.arn
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_AWSCodeBuildDeveloperAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.AWSCodeBuildDeveloperAccess.arn
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_AmazonEC2FullAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.AmazonEC2FullAccess.arn
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_AmazonEC2ContainerRegistryFullAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.AmazonEC2ContainerRegistryFullAccess.arn
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_AmazonSSMFullAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.AmazonSSMFullAccess.arn
}
resource "aws_iam_role_policy_attachment" "orjujeng_codebuild_role_attach_AmazonS3FullAccess" {
  role       = "orjujeng_codebuild_role"
  policy_arn = data.aws_iam_policy.AmazonS3FullAccess.arn
}

#code artifacts result in new s3
resource "aws_s3_bucket" "artifacts_file" {
  bucket = "orjujeng-codebuild-artifacts"

  tags = {
    Name = "orjujeng_codebuild_artifacts"
  }
}

#code build cache in new s3
resource "aws_s3_bucket" "cache_file" {
  bucket = "orjujeng-codebuild-cache"

  tags = {
    Name = "orjujeng-codebuild-cache"
  }
}
# codebuild log group
resource "aws_cloudwatch_log_group" "orjujeng_codebuild_log_group" {
  name              = "orjujeng_codebuild_log_group"
  retention_in_days = 3
  tags = {
    name = "orjujeng_codebuild_log_group"
  }
}

resource "aws_cloudwatch_log_stream" "orjujeng_codebuild_log_group_steam" {
  name           = "orjujeng_codebuild_poc"
  log_group_name = aws_cloudwatch_log_group.orjujeng_codebuild_log_group.name
}

resource "aws_codebuild_project" "orjujeng_codebuild_poc" {
  name                 = "orjujeng_codebuild_poc"
  description          = "orjujeng_codebuild_poc"
  build_timeout        = 60
  service_role         = aws_iam_role.orjujeng_codebuild_role.arn
  resource_access_role = aws_iam_role.orjujeng_codebuild_role.arn

  artifacts {
    type      = "S3"
    location  = "${aws_s3_bucket.artifacts_file.bucket}"
    packaging = "ZIP"
    path      = "/orjujeng_codebuild_poc/"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.cache_file.bucket}"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:corretto8"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true
    environment_variable {
      name  = "REPO_HTTPS"
      value = "https://github.com/orjujeng/th-manager-api.git"
    }
  }

  logs_config {
    cloudwatch_logs {
      group_name  = aws_cloudwatch_log_group.orjujeng_codebuild_log_group.name
      stream_name = aws_cloudwatch_log_stream.orjujeng_codebuild_log_group_steam.name
    }
  }

  source {
    type            = "NO_SOURCE"
    buildspec       = file("./buildspec/code_compile.yml")
  }

  # vpc_config {
  #   vpc_id = aws_vpc.orjujeng_vpc.id

  #   subnets = [
  #     aws_subnet.orjujeng_inside_net_1a.id,
  #     aws_subnet.orjujeng_inside_net_1c.id,
  #   ]

  #   security_group_ids = [
  #     aws_security_group.orjujeng_codebuild_sg.id
  #   ]
  # }

  tags = {
    Name = "orjujeng_codebuild_poc"
  }
}