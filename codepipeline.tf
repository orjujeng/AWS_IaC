#orjujeng_codepipeline_poc
# iam 

resource "aws_iam_role" "orjujeng_codepipeline_role" {
  name               = "orjujeng_codepipeline_role"
  assume_role_policy = data.aws_iam_policy_document.orjujeng_codepipeline_assume_role.json
}

data "aws_iam_policy_document" "orjujeng_codepipeline_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codepipeline.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "orjujeng_codepipeline_policy" {
  statement {
    effect = "Allow"

    actions = [
      "s3:*"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"

    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "codedeploy:*"
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"

    actions = [
      "codedeploy:*"
    ]

    resources = ["*"]
  }
  statement {
    effect = "Allow"

    actions = [
      "iam:PassRole"
    ]

    resources = ["*"]
  }
  
}

resource "aws_iam_role_policy" "orjujeng_codepipeline_policy" {
  name   = "orjujeng_codepipeline_policy"
  role   = aws_iam_role.orjujeng_codepipeline_role.id
  policy = data.aws_iam_policy_document.orjujeng_codepipeline_policy.json
}

#codepipline
# resource "aws_codepipeline" "orjujeng_codepipeline_poc" {
#   name     = "orjujeng-codepipeline-poc"
#   role_arn = aws_iam_role.orjujeng_codepipeline_role.arn

#   artifact_store {
#     location = aws_s3_bucket.artifacts_file.bucket
#     type     = "S3"
#   }

#   stage {
#     name = "Source"

#     action {
#       name             = "PlaceholdSource"
#       category         = "Source"
#       owner            = "AWS"
#       provider         = "S3"
#       version          = "1"
#       output_artifacts = ["source_output"]
#       configuration = {
#         S3Bucket    = aws_s3_bucket.artifacts_file.bucket
#         S3ObjectKey = "source_input/placeholder.zip"
#       }
#     }
#   }

#   stage {
#     name = "Approval-Needed"

#     action {
#       name     = "ManualApproval"
#       category = "Approval"
#       owner    = "AWS"
#       provider = "Manual"
#       version  = "1"
#       configuration = {
#         "CustomData" : "Below Action Will Use Codebuild"
#       }
#     }
#   }

#   stage {
#     name = "Build"

#     action {
#       name             = "Build"
#       category         = "Build"
#       owner            = "AWS"
#       provider         = "CodeBuild"
#       input_artifacts  = ["source_output"]
#       output_artifacts = ["poc_build_output"]
#       version          = "1"
#       configuration = {
#         ProjectName = aws_codebuild_project.orjujeng_codebuild_poc.name
#       }
#     }
#   }

#   stage {
#     name = "Deploy"

#     action {
#       name            = "Deploy"
#       category        = "Deploy"
#       owner           = "AWS"
#       provider        = "CodeDeploy"
#       input_artifacts = ["poc_build_output"]
#       version         = "1"

#       configuration = {
#         ApplicationName     = aws_codedeploy_app.orjujeng_codedeploy_poc_app.name
#         DeploymentGroupName = aws_codedeploy_deployment_group.orjujeng_codedeploy_poc_group.deployment_group_name
#       }
#     }
#   }
#   tags = {
#     Name = "orjujeng_codedeploy_poc"
#   }
# }


#ecs codepipeline
resource "aws_codepipeline" "orjujeng_ecs_codepipeline" {
  name     = "orjujeng-esc-codepipeline"
  role_arn = aws_iam_role.orjujeng_codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.artifacts_file.bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "PlaceholdSource"
      category         = "Source"
      owner            = "AWS"
      provider         = "S3"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        S3Bucket    = aws_s3_bucket.artifacts_file.bucket
        S3ObjectKey = "source_input/placeholder.zip"
      }
    }
  }

  stage {
    name = "Approval-Needed"

    action {
      name     = "ManualApproval"
      category = "Approval"
      owner    = "AWS"
      provider = "Manual"
      version  = "1"
      configuration = {
        "CustomData" : "Below Action Will Use Codebuild"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["ecs_images_build_output"]
      version          = "1"
      configuration = {
        ProjectName = aws_codebuild_project.orjujeng_codebuild_ecs_compile.name
      }
    }
  }

  stage {
    name = "Deploy"

    action {
      name            = "Deploy"
      category        = "Deploy"
      owner           = "AWS"
      provider        = "ECS"
      input_artifacts = ["ecs_images_build_output"]
      version         = "1"

      configuration = {
        ClusterName = aws_ecs_cluster.orjujeng_ecs_cluster.name
        ServiceName = aws_ecs_service.orjujeng_service.name
        FileName = "imagedefinitions.json"
      }
    }
  }
  tags = {
    Name = "orjujeng_ecs_codepipeline"
  }
}