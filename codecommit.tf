# resource "aws_codecommit_repository" "orjujeng_repo_test" {
#   repository_name = "orjujeng-repo-test"
#   description     = "orjujeng-repo-test"
# }

# #new iam user for git commit
# resource "aws_iam_user" "orjujeng_codecommit" {
#   name = "orjujeng_codecommit"
#   path = "/"
#   force_destroy = true
#   tags = {
#     name = "orjujeng_codecommit"
#   }
# }

# resource "aws_iam_policy" "orjujeng_codecommit_policy" {
#   name        = "orjujeng_codecommit_policy"
#   description = "orjujeng_codecommit_policy"
#   policy = jsonencode({
#     "Version" : "2012-10-17",
#     "Statement" : [
#       {
#         "Sid" : "VisualEditor0",
#         "Effect" : "Allow",
#         "Action" : [
#           "codecommit:ListRepositoriesForApprovalRuleTemplate",
#           "codecommit:CreateApprovalRuleTemplate",
#           "codecommit:UpdateApprovalRuleTemplateName",
#           "codecommit:GetApprovalRuleTemplate",
#           "codecommit:ListApprovalRuleTemplates",
#           "codecommit:DeleteApprovalRuleTemplate",
#           "codecommit:ListRepositories",
#           "codecommit:UpdateApprovalRuleTemplateContent",
#           "codecommit:UpdateApprovalRuleTemplateDescription"
#         ],
#         "Resource" : "*"
#       },
#       {
#         "Sid" : "VisualEditor1",
#         "Effect" : "Allow",
#         "Action" : "codecommit:*",
#         "Resource" : "arn:aws:codecommit:ap-northeast-1:877401119357:*"
#       }
#     ]
#   })
# }
# #attach
# resource "aws_iam_user_policy_attachment" "orjujeng_codecommit_attach_policy" {
#   user       = aws_iam_user.orjujeng_codecommit.name
#   policy_arn = aws_iam_policy.orjujeng_codecommit_policy.arn
# }