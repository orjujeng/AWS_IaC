terraform {
  required_version = ">=v1.6.6"
  backend "s3" {
    region         = "ap-northeast-1"
    bucket         = "orjujeng-tfstate"
    key            = "terraform.tfstate"
    dynamodb_table = "orjujeng_terraform_lock"
    encrypt        = true
  }
}

//you will use aksk to connect the aws account.
// don't forget set the ak & sk to the path varibale when this code push to the public repo
// aws configure to set aksk and region
provider "aws" {
  region = var.region
}
provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}
