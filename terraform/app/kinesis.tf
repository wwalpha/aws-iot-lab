# ----------------------------------------------------------------------------------------------
# AWS Kinesis Data Stream - Iot Events
# ----------------------------------------------------------------------------------------------
resource "aws_kinesis_stream" "events" {
  name             = local.kinesis_data_stream_iot
  retention_period = 24

  stream_mode_details {
    stream_mode = "ON_DEMAND"
  }
}
