output "application-management-arn" {
  value = aws_lambda_function.application_management_lambda.arn
}

output "commercial-management-arn" {
  value = aws_lambda_function.commercial_management_lambda.arn
}