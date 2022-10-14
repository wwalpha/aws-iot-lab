# ----------------------------------------------------------------------------------------------
# AWS IoT Rule Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "iot_rule" {
  name               = "${var.project_name_uc}_IoTRuleRole"
  assume_role_policy = data.aws_iam_policy_document.iot.json

  lifecycle {
    create_before_destroy = false
  }
}

# ----------------------------------------------------------------------------------------------
# AWS IoT Rule Role Policy
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy" "iot_rule" {
  name = "iot_rule"
  role = aws_iam_role.iot_rule.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
    ]
  })
}
