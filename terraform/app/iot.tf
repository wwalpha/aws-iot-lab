# ----------------------------------------------------------------------------------------------
# IoT Topic Rule - Status
# ----------------------------------------------------------------------------------------------
resource "aws_iot_topic_rule" "status" {
  name        = local.topic_rule_status
  enabled     = true
  sql         = "SELECT * FROM 'topic/status'"
  sql_version = "2016-03-23"

  firehose {
    delivery_stream_name = var.kinesis_firehose_name
    role_arn             = var.iot_rule_role_arn
  }

  cloudwatch_logs {
    log_group_name = aws_cloudwatch_log_group.iot_rules.name
    role_arn       = var.iot_rule_role_arn
  }
}

# ----------------------------------------------------------------------------------------------
# IoT Topic Rule - Alarm
# ----------------------------------------------------------------------------------------------
# resource "aws_iot_topic_rule" "alarm" {
#   name        = local.topic_rule_status
#   enabled     = true
#   sql         = "SELECT * FROM 'topic/alarm'"
#   sql_version = "2016-03-23"

#   firehose {
#     delivery_stream_name = var.kinesis_firehose_name
#     role_arn             = var.kinesis_firehose_role_arn
#   }
# }
