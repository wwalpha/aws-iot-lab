# ---------------------------------------------------------------------------------------------
# CloudWatch Log Group - API Gateway
# ---------------------------------------------------------------------------------------------
resource "aws_cloudwatch_log_group" "api" {
  name              = "/iot/api"
  retention_in_days = 7
}
