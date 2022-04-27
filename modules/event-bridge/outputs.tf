output "cloudwatch-event-trigger-app-management-arn" {
  value = aws_cloudwatch_event_rule.application_lambda_event_rule.arn
}

output "cloudwatch-event-trigger-commercial-management-arn" {
  value = aws_cloudwatch_event_rule.commercial_lambda_event_rule.arn
}
output "cloudwatch-event-trigger-risk-management-arn" {
  value = aws_cloudwatch_event_rule.risk_lambda_event_rule.arn
}