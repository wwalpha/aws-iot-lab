# ---------------------------------------------------------------------------------------------
# CloudWatch Log Group - IoT Rule
# ---------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "iot_rules" {
  name              = "/iot/rules"
  retention_in_days = 7
}
