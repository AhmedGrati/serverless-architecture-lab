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
  cloudwatch-event-trigger-risk-management-arn = module.event-bridge.cloudwatch-event-trigger-risk-management-arn
  cloudwatch-event-trigger-ocr-management-arn = module.event-bridge.cloudwatch-event-trigger-ocr-management-arn
  cloudwatch-event-trigger-client-arn = module.event-bridge.cloudwatch-event-trigger-client-arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}
module "event-bridge" {
  source                     = "./modules/event-bridge"
  application-management-arn = module.lambda.application-management-arn
  commercial-management-arn  = module.lambda.commercial-management-arn
  risk-management-arn = module.lambda.risk-management-arn
  ocr-management-arn = module.lambda.ocr-management-arn
  client-arn = module.lambda.client-arn
}
