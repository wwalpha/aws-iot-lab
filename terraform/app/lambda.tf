# ----------------------------------------------------------------------------------------------
# Lambda Function - Kinesis stream events
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "kinesis_stream_events" {
  depends_on        = [aws_s3_bucket.materials]
  function_name     = "${var.project_name}-kinesis-events"
  s3_bucket         = local.bucket_name_materials
  s3_key            = aws_s3_object.lambda_module.key
  s3_object_version = aws_s3_object.lambda_module.version_id
  handler           = local.lambda_handler_nodejs
  runtime           = local.lambda_runtime_nodejs
  memory_size       = 1024
  role              = var.lambda_role_arn_kinesis_stream_events
  timeout           = 10
  layers            = [aws_lambda_layer_version.libraries_dynamodb.arn]

  environment {
    variables = {
      AWS_NODEJS_CONNECTION_REUSE_ENABLED = "1"
      TABLE_NAME_DEVICE_STATUS            = var.dynamodb_table_name_device_status
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Lambda Function Permission - Kinesis stream events
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_permission" "kinesis_stream_events" {
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.kinesis_stream_events.function_name
  principal     = "kinesis.amazonaws.com"
  source_arn    = aws_kinesis_stream.events.arn
}

# ----------------------------------------------------------------------------------------------
# Lambda Function Event Source Mapping - Kinesis stream events
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_event_source_mapping" "kinesis_stream_events" {
  event_source_arn  = aws_kinesis_stream.events.arn
  function_name     = aws_lambda_function.kinesis_stream_events.function_name
  starting_position = "LATEST"
}

# ----------------------------------------------------------------------------------------------
# Lambda Layer - @alphax/dynamodb
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_layer_version" "libraries_dynamodb" {
  depends_on          = [aws_s3_bucket.materials]
  layer_name          = "dynamodb"
  s3_bucket           = local.bucket_name_materials
  s3_key              = aws_s3_object.libraries_dynamodb.key
  s3_object_version   = aws_s3_object.libraries_dynamodb.version_id
  compatible_runtimes = ["nodejs14.x"]
}

