
# ----------------------------------------------------------------------------------------------
# Amazon API Gateway Service Integration Role - SQS
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "apigw_svr_sqs" {
  name               = "${var.project_name_uc}_APIGW_SQSRole"
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
