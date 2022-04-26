resource "aws_cloudwatch_log_group" "lambda-log-group" {
  name = "/aws/lambda/ocr-application"
  retention_in_days = 14
}