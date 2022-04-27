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
  source                                      = "./modules/lambda"
  cloudwatch-event-trigger-app-management-arn = module.event-bridge.cloudwatch-event-trigger-app-management-arn
  cloudwatch-event-trigger-commercial-management-arn = module.event-bridge.cloudwatch-event-trigger-commercial-management-arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}
module "event-bridge" {
  source                     = "./modules/event-bridge"
  application-management-arn = module.lambda.application-management-arn
  commercial-management-arn  = module.lambda.commercial-management-arn
}
