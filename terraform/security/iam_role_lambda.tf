# ----------------------------------------------------------------------------------------------
# AWS Lambda Basic Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_basic" {
  name               = "${var.project_name_uc}_Lambda_BasicRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json

  lifecycle {
    create_before_destroy = false
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Lambda Basic Role Policy - CloudWatch Basic Policy
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_basic" {
  role       = aws_iam_role.lambda_basic.name
  policy_arn = aws_iam_policy.cloudwatch_logs_basic.arn
}

# ----------------------------------------------------------------------------------------------
# AWS Lambda Role - Kinesis Stream Events
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "lambda_kinesis_stream_events" {
  name               = "${var.project_name_uc}_Kinesis_EventsRole"
  assume_role_policy = data.aws_iam_policy_document.lambda.json

  lifecycle {
    create_before_destroy = false
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Lambda Role Policy - Kinesis Stream Events with cloudwatch permission
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "lambda_kinesis_stream_events_with_basic" {
  role       = aws_iam_role.lambda_kinesis_stream_events.id
  policy_arn = aws_iam_policy.cloudwatch_logs_basic.arn
}

# ----------------------------------------------------------------------------------------------
# AWS Lambda Role Policy - Kinesis Stream Events with cloudwatch permission
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy" "lambda_kinesis_stream_events_kinesis" {
  name = "kinesis_policy"
  role = aws_iam_role.lambda_kinesis_stream_events.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "kinesis:ListStreams",
          "kinesis:ListShards",
          "kinesis:GetShardIterator",
          "kinesis:GetRecords",
          "kinesis:DescribeStream"
        ]
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "dynamodb:BatchGetItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem",
          "dynamodb:GetItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:UpdateItem"
        ]
        Resource = "*"
      },
    ]
  })
}
