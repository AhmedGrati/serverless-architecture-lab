terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region = var.aws-region
}

module "lambda" {
  source = "./modules/lambda"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}
