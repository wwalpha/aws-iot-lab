# ----------------------------------------------------------------------------------------------
# Dynamodb Table Name - Device Status
# ----------------------------------------------------------------------------------------------
output "dynamodb_table_name_device_status" {
  value = aws_dynamodb_table.device_status.arn
}

