# ----------------------------------------------------------------------------------------------
# AWS IAM Policy - CloudWatch Logs Basic
# ----------------------------------------------------------------------------------------------
resource "aws_iam_policy" "cloudwatch_logs_basic" {
  name = "IoT_CloudWatchLogsPolicy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}
