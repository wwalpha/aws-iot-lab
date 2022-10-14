# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {}

# ----------------------------------------------------------------------------------------------
# Terraform Settings
# ----------------------------------------------------------------------------------------------
terraform {
  backend "remote" {
    organization = "wwalpha"

    workspaces {
      name = "aws-iot-lab"
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Security Module
# ----------------------------------------------------------------------------------------------
module "security" {
  source          = "./security"
  project_name_uc = local.project_name_uc
}

# ----------------------------------------------------------------------------------------------
# Iot Module
# ----------------------------------------------------------------------------------------------
# module "iot_devices" {
#   depends_on = [
#     module.security
#   ]

#   source                = "./device"
#   lambda_basic_role_arn = module.security.lambda_basic_role_arn
# }

# ----------------------------------------------------------------------------------------------
# Functions for frontend request
# ----------------------------------------------------------------------------------------------
# module "frontend" {
#   depends_on = [
#     module.security
#   ]

#   source             = "./frontend"
#   apigw_sqs_role_arn = module.security.apigw_sqs_role_arn
# }

# ----------------------------------------------------------------------------------------------
# Backend functions
# ----------------------------------------------------------------------------------------------
module "datalake" {
  depends_on = [
    module.security
  ]

  source                    = "./datalake"
  project_name              = local.project_name
  kinesis_firehose_role_arn = module.security.kinesis_firehose_role_arn
}

# ----------------------------------------------------------------------------------------------
# Databases
# ----------------------------------------------------------------------------------------------
module "database" {
  source       = "./database"
  project_name = local.project_name
}

# ----------------------------------------------------------------------------------------------
# App
# ----------------------------------------------------------------------------------------------
module "app" {
  source                    = "./app"
  project_name              = local.project_name
  kinesis_firehose_name     = module.datalake.kinesis_firehose_name
  iot_rule_role_arn = module.security.iot_rule_role_arn
}
