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
      "source": ["client.events"]
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