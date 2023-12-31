resource "aws_s3_bucket" "orjujeng-tfstate" {
  bucket = "${var.perfix}-tfstate"

  tags = {
    Name        = "orjujeng_tfstate"
  }
}