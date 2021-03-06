output "application-management-arn" {
  value = aws_lambda_function.application_management_lambda.arn
}

output "commercial-management-arn" {
  value = aws_lambda_function.commercial_management_lambda.arn
}
output "risk-management-arn" {
  value = aws_lambda_function.risk_management_lambda.arn
}
output "ocr-management-arn" {
  value = aws_lambda_function.ocr.arn
}
output "client-arn" {
  value = aws_lambda_function.client_lambda.arn
}