resource "aws_dynamodb_table" "orjujeng_terraform_lock" {
  name           = "orjujeng_terraform_lock"
  hash_key       = "LockID"
  read_capacity  = 1
  write_capacity = 1

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "orjujeng_terraform_lock_table"
  }
}