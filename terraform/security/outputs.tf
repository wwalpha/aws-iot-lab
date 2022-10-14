# ----------------------------------------------------------------------------------------------
# IAM Role Arn - Amazon API Gateway Service Integration Role (SQS)
# ----------------------------------------------------------------------------------------------
output "apigw_sqs_role_arn" {
  value = aws_iam_role.apigw_svr_sqs.arn
}


# ----------------------------------------------------------------------------------------------
# IAM Role Arn - Kinesis firehose export to s3 bucket
# ----------------------------------------------------------------------------------------------
output "firehose_role_arn_datalake" {
  value = aws_iam_role.kinesis_firehose.arn
}

# ----------------------------------------------------------------------------------------------
# Iot Role Arn - Topic/Status
# ----------------------------------------------------------------------------------------------
output "iot_role_arn_status" {
  value = aws_iam_role.iot_rule.arn
}

# ----------------------------------------------------------------------------------------------
# Lambda Role Arn - Basic
# ----------------------------------------------------------------------------------------------
output "lambda_role_arn_basic" {
  value = aws_iam_role.lambda_basic.arn
}

# ----------------------------------------------------------------------------------------------
# Lambda Role Arn - Kinesis Stream Events
# ----------------------------------------------------------------------------------------------
output "lambda_role_arn_kinesis_stream_events" {
  value = aws_iam_role.lambda_kinesis_stream_events.arn
}
