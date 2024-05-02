terraform {
  backend "s3" {
    bucket         = "cwd-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamo-lock"
  }
}
