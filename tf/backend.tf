provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = "Test"
      Owner       = "TFProviders"
      Project     = "TestProject"
    }
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id
  region     = data.aws_region.current.name
}

terraform {
  backend "s3" {
    bucket         = "reinvent2023-boa203"             # Hardcoded until Terraform starts supporting 
    key            = "terraform.key"                 # variables in backend config block
    dynamodb_table = "reinvent2023-boa203-db"          # see: https://github.com/hashicorp/terraform/issues/13022
    region         = "eu-west-1"                       #
    encrypt        = true
  }
}