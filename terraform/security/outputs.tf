# ----------------------------------------------------------------------------------------------
# IAM Role Arn - Lambda Basic
# ----------------------------------------------------------------------------------------------
output "lambda_basic_role_arn" {
  value = aws_iam_role.lambda_basic_role.arn
}

# ----------------------------------------------------------------------------------------------
# IAM Role Arn - Amazon API Gateway Service Integration Role (SQS)
# ----------------------------------------------------------------------------------------------
output "apigw_sqs_role_arn" {
  value = aws_iam_role.apigw_svr_sqs.arn
}


# ----------------------------------------------------------------------------------------------
# IAM Role Arn - Kinesis firehose export to s3 bucket
# ----------------------------------------------------------------------------------------------
output "kinesis_firehose_role_arn" {
  value = aws_iam_role.kinesis_firehose.arn
}
