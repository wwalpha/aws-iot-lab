# ----------------------------------------------------------------------------------------------
# Dynamodb Table - Device status
# ----------------------------------------------------------------------------------------------
resource "aws_dynamodb_table" "device_status" {
  name         = local.dynamodb_name_device_status
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }
}
