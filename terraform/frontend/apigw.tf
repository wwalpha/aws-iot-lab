# ---------------------------------------------------------------------------------------------
# API Gateway
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_api" "this" {
  name          = "iot-api"
  protocol_type = "HTTP"

  cors_configuration {
    allow_origins = ["*"]
    allow_headers = ["*"]
    allow_methods = ["GET", "POST", "OPTIONS"]
  }
}

# ---------------------------------------------------------------------------------------------
# API Gateway Stage
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_stage" "this" {
  api_id      = aws_apigatewayv2_api.this.id
  name        = "$default"
  auto_deploy = true

  access_log_settings {
    destination_arn = aws_cloudwatch_log_group.api.arn
    format = jsonencode(
      {
        apiId              = "$context.apiId"
        httpMethod         = "$context.httpMethod"
        ip                 = "$context.identity.sourceIp"
        protocol           = "$context.protocol"
        requestId          = "$context.requestId"
        requestTime        = "$context.requestTime"
        responseLength     = "$context.responseLength"
        responseLatency    = "$context.responseLatency"
        routeKey           = "$context.routeKey"
        integrationLatency = "$context.integrationLatency"
        status             = "$context.status"
        error              = "$context.authorizer.error"
      }
    )
  }
}

# ---------------------------------------------------------------------------------------------
# API Gateway Integration - Users
# ---------------------------------------------------------------------------------------------
resource "aws_apigatewayv2_integration" "sqs" {
  api_id              = aws_apigatewayv2_api.this.id
  credentials_arn     = var.apigw_sqs_role_arn
  integration_type    = "AWS_PROXY"
  integration_subtype = "SQS-SendMessage"

  request_parameters = {
    "QueueUrl"    = "$request.header.queueUrl"
    "MessageBody" = "$request.body.message"
  }
}
