# ----------------------------------------------------------------------------------------------
# AWS Kinesis Firehose - Export to S3
# ----------------------------------------------------------------------------------------------
resource "aws_kinesis_firehose_delivery_stream" "s3" {
  name        = "${var.project_name}_export_to_s3"
  destination = "extended_s3"

  extended_s3_configuration {
    role_arn   = var.firehose_role_arn
    bucket_arn = aws_s3_bucket.data_lake.arn

    # processing_configuration {
    #   enabled = "true"

    #   processors {
    #     type = "Lambda"

    #     parameters {
    #       parameter_name  = "LambdaArn"
    #       parameter_value = "${aws_lambda_function.lambda_processor.arn}:$LATEST"
    #     }
    #   }
    # }
  }
}
