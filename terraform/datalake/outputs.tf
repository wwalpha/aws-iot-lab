# ----------------------------------------------------------------------------------------------
# Kinesis firehose Name
# ----------------------------------------------------------------------------------------------
output "kinesis_firehose_name" {
  value = aws_kinesis_firehose_delivery_stream.s3.name
}

# ----------------------------------------------------------------------------------------------
# Kinesis firehose Arn
# ----------------------------------------------------------------------------------------------
output "kinesis_firehose_arn" {
  value = aws_kinesis_firehose_delivery_stream.s3.arn
}
