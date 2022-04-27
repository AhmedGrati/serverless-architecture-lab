resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = file("resources/iam/lambda-role.json")
}
locals {
  application_management_zip_location = "outputs/application_management.zip"
  commercial_management_zip_location = "outputs/commercial_management.zip"
  risk_management_zip_location = "outputs/risk_management.zip"
  ocr_zip_location = "outputs/ocr.zip"
  client_zip_location = "outputs/client.zip"
}
resource "aws_lambda_function" "application_management_lambda" {
  filename         = local.application_management_zip_location
  function_name    = "application_management"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "application_management.handle"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(local.application_management_zip_location)
  depends_on = [
    aws_iam_policy_attachment.lambda_logs
  ]
}

resource "aws_lambda_function" "commercial_management_lambda" {
  filename         = local.commercial_management_zip_location
  function_name    = "commercial_management"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "commercial_management.handle"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(local.commercial_management_zip_location)
  depends_on = [
    aws_iam_policy_attachment.lambda_logs
  ]
}

resource "aws_lambda_function" "risk_management_lambda" {
  filename         = local.risk_management_zip_location
  function_name    = "risk_management"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "risk_management.handle"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(local.risk_management_zip_location)
  depends_on = [
    aws_iam_policy_attachment.lambda_logs
  ]
}

resource "aws_lambda_function" "ocr" {
  filename         = local.ocr_zip_location
  function_name    = "ocr"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "ocr.handle"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(local.ocr_zip_location)
  depends_on = [
    aws_iam_policy_attachment.lambda_logs
  ]
}

resource "aws_lambda_function" "client_lambda" {
  filename         = local.client_zip_location
  function_name    = "client"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "client.handle"
  runtime          = "python3.9"
  source_code_hash = filebase64sha256(local.client_zip_location)
  depends_on = [
    aws_iam_policy_attachment.lambda_logs
  ]
}
resource "aws_lambda_permission" "allow_cloudwatch_trigger_application_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.application_management_lambda.arn
  principal = "events.amazonaws.com"
  source_arn = var.cloudwatch-event-trigger-app-management-arn
  statement_id = "AllowInvokationFromCloudWatchEvent"
}

resource "aws_lambda_permission" "allow_cloudwatch_trigger_commercial_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.commercial_management_lambda.arn
  principal = "events.amazonaws.com"
  source_arn = var.cloudwatch-event-trigger-commercial-management-arn
  statement_id = "AllowInvokationFromCloudWatchEvent"
}
resource "aws_lambda_permission" "allow_cloudwatch_trigger_risk_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.risk_management_lambda.arn
  principal = "events.amazonaws.com"
  source_arn = var.cloudwatch-event-trigger-risk-management-arn
  statement_id = "AllowInvokationFromCloudWatchEvent"
}
resource "aws_lambda_permission" "allow_cloudwatch_trigger_ocr_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ocr.arn
  principal = "events.amazonaws.com"
  source_arn = var.cloudwatch-event-trigger-ocr-management-arn
  statement_id = "AllowInvokationFromCloudWatchEvent"
}
resource "aws_lambda_permission" "allow_cloudwatch_trigger_client_lambda" {
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.client_lambda.arn
  principal = "events.amazonaws.com"
  source_arn = var.cloudwatch-event-trigger-client-arn
  statement_id = "AllowInvokationFromCloudWatchEvent"
}

resource "aws_iam_policy" "lambda_logging" {
  name        = "lambda_logging"
  path        = "/"
  description = "IAM Policy for logging from a lambda to cloudwatch"

  policy = file("resources/iam/lambda-cloudwatch-policy.json")
}

resource "aws_iam_policy_attachment" "lambda_logs" {
  name       = "lambda_logs_policy_attach"
  roles      = [aws_iam_role.iam_for_lambda.name]
  policy_arn = aws_iam_policy.lambda_logging.arn
}
