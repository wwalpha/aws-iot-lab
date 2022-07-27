locals {
  lambda_runtime_python = "python3.9"
  lambda_handler_python = "index.lambda_handler"
  lambda_runtime_nodejs = "nodejs14.x"
  lambda_handler_nodejs = "index.handler"

  account_id = data.aws_caller_identity.this.account_id
  region     = data.aws_region.this.name
}

# ----------------------------------------------------------------------------------------------
# AWS Region
# ----------------------------------------------------------------------------------------------
data "aws_region" "this" {}

# ----------------------------------------------------------------------------------------------
# AWS Account
# ----------------------------------------------------------------------------------------------
data "aws_caller_identity" "this" {}
