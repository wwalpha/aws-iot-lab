# ----------------------------------------------------------------------------------------------
# Lambda Function - Iot Component for Local (Python)
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "iot_python_local" {
  filename         = "${path.module}/source/lambda_python.zip"
  source_code_hash = filebase64sha256("${path.module}/source/lambda_python.zip")
  function_name    = "iot-greengrass-python-local"
  architectures    = ["arm64"]
  handler          = local.lambda_handler_python
  memory_size      = 128
  role             = var.lambda_basic_role_arn
  runtime          = local.lambda_runtime_python
  timeout          = 10
  publish          = true

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}

# ----------------------------------------------------------------------------------------------
# Lambda Function - Iot Component for Remote (Python)
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "iot_python_remote" {
  filename         = "${path.module}/source/lambda_python.zip"
  source_code_hash = filebase64sha256("${path.module}/source/lambda_python.zip")
  function_name    = "iot-greengrass-python"
  architectures    = ["arm64"]
  handler          = local.lambda_handler_python
  memory_size      = 128
  role             = var.lambda_basic_role_arn
  runtime          = local.lambda_runtime_python
  timeout          = 10
  publish          = true

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}

# ----------------------------------------------------------------------------------------------
# Lambda Function - Iot Component for Local (Node.js)
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "iot_nodejs_local" {
  filename         = "${path.module}/source/lambda_nodejs.zip"
  source_code_hash = filebase64sha256("${path.module}/source/lambda_nodejs.zip")
  function_name    = "iot-greengrass-nodejs-local"
  architectures    = ["arm64"]
  handler          = local.lambda_handler_nodejs
  memory_size      = 128
  role             = var.lambda_basic_role_arn
  runtime          = local.lambda_runtime_nodejs
  timeout          = 10
  publish          = true

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}

# ----------------------------------------------------------------------------------------------
# Lambda Function - Iot Component for Remote (Node.js)
# ----------------------------------------------------------------------------------------------
resource "aws_lambda_function" "iot_nodejs_remote" {
  filename         = "${path.module}/source/lambda_nodejs.zip"
  source_code_hash = filebase64sha256("${path.module}/source/lambda_nodejs.zip")
  function_name    = "iot-greengrass-nodejs2"
  architectures    = ["arm64"]
  handler          = local.lambda_handler_nodejs
  memory_size      = 128
  role             = var.lambda_basic_role_arn
  runtime          = local.lambda_runtime_nodejs
  timeout          = 10
  publish          = true

  lifecycle {
    ignore_changes = [
      source_code_hash
    ]
  }
}
