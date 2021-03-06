resource "aws_cloudwatch_event_rule" "application_lambda_event_rule" {
  name        = "application-event-requested"
  description = "Application Lambda Microservice Event Rule"

  event_pattern = <<EOF
    {
      "detail-type": ["application-event-requested"],
      "source": ["client.events"]
    }

EOF
}


resource "aws_cloudwatch_event_rule" "commercial_lambda_event_rule" {
  name        = "commercial-event-requested"
  description = "Commercial Lambda Microservice Event Rule"

  event_pattern = <<EOF
    {
      "detail-type": ["commercial-event-requested"],
      "source": ["application.events"]
    }

EOF
}

resource "aws_cloudwatch_event_rule" "risk_lambda_event_rule" {
  name        = "risk-event-requested"
  description = "Risk Lambda Microservice Event Rule"

  event_pattern = <<EOF
    {
      "detail-type": ["risk-event-requested"],
      "source": ["commercial.events"]
    }

EOF
}
resource "aws_cloudwatch_event_rule" "ocr_lambda_event_rule" {
  name        = "ocr-event-requested"
  description = "OCR Lambda Microservice Event Rule"

  event_pattern = <<EOF
    {
      "detail-type": ["ocr-event-requested"],
      "source": ["risk.events"]
    }

EOF
}

resource "aws_cloudwatch_event_rule" "client_lambda_event_rule" {
  name        = "application-response-event"
  description = "Client Lambda Microservice Event Rule"

  event_pattern = <<EOF
    {
      "detail-type": ["application-response-event"],
      "source": ["ocr.events"]
    }

EOF
}
resource "aws_cloudwatch_event_permission" "allow_client_lambda_put_event" {
  action       = "events:PutEvents"
  principal    = "*"
  statement_id = "AllowInvokationFromLambda"
}
resource "aws_cloudwatch_event_target" "application-managament-lambda-event-target" {
  rule      = aws_cloudwatch_event_rule.application_lambda_event_rule.name
  target_id = "AppManagementId"
  arn       = var.application-management-arn
}

resource "aws_cloudwatch_event_target" "commercial-managament-lambda-event-target" {
  rule      = aws_cloudwatch_event_rule.commercial_lambda_event_rule.name
  target_id = "CommercialManagementId"
  arn       = var.commercial-management-arn
}
resource "aws_cloudwatch_event_target" "risk-managament-lambda-event-target" {
  rule      = aws_cloudwatch_event_rule.risk_lambda_event_rule.name
  target_id = "RiskManagementId"
  arn       = var.risk-management-arn
}
resource "aws_cloudwatch_event_target" "ocr-managament-lambda-event-target" {
  rule      = aws_cloudwatch_event_rule.ocr_lambda_event_rule.name
  target_id = "OCRManagementId"
  arn = var.ocr-management-arn
}
resource "aws_cloudwatch_event_target" "client-lambda-event-target" {
  rule      = aws_cloudwatch_event_rule.client_lambda_event_rule.name
  target_id = "OCRManagementId"
  arn = var.client-arn
}