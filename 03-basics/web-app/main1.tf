#terraform {
#  backend "s3" {
    # Replace this with your bucket name!
  #  bucket         = "devops-directive-tff-state"
  #  key            = "global/s3/terraform.tfstate"
   # profile        = "AWS_PROFILE"
   # region         = "us-east-1"
  #  access_key     = "AKIA57AOYR34MCXEVJTC" 
  #  secret_key     = "36rPZy/FUkLrgfjsQXuD+OmpYt7F8ueEHHdz0nC4"
    # Replace this with your DynamoDB table name!
 #   dynamodb_table = "terraform-state-locking"
 #   encrypt        = true
#  }
#}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "terraform_state" {
  bucket = "great-name-terraform-state-2"
  # Enable versioning so we can see the full revision history of our
  # state files
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "great-name-locks-2"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
    }
}