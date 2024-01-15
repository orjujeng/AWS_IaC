resource "aws_ecrpublic_repository" "orjujeng_ecr_pubilc_repo" {

  provider        = aws.us_east_1
  repository_name = "orjujeng_ecr_pubilc_repo"

  catalog_data {
    architectures     = ["ARM"]
    operating_systems = ["Linux"]
  }
  tags = {
    Name = "orjujeng_ecr_pubilc_repo"
  }
}