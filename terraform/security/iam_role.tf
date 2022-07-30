# ----------------------------------------------------------------------------------------------
# AWS Lambda Basic Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_basic_role" {
  name               = "IoT_Lambda_BasicRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json

  lifecycle {
    create_before_destroy = false
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Lambda Basic Role Policy - CloudWatch Basic Policy
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_basic" {
  role       = aws_iam_role.lambda_basic_role.name
  policy_arn = aws_iam_policy.cloudwatch_logs_basic.arn
}

# ----------------------------------------------------------------------------------------------
# Amazon API Gateway Service Integration Role - SQS
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "apigw_svr_sqs" {
  name               = "IoT_APIGW_SQSRole"
  assume_role_policy = data.aws_iam_policy_document.apigw.json

  lifecycle {
    create_before_destroy = false
  }
}

# ----------------------------------------------------------------------------------------------
# Amazon API Gateway Service Integration Role Policy - SQS
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "apigw_svr_sqs" {
  role       = aws_iam_role.apigw_svr_sqs.name
  policy_arn = aws_iam_policy.apigw_srv_sqs.arn
}
