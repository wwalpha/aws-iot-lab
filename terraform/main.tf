# ----------------------------------------------------------------------------------------------
# AWS Provider
# ----------------------------------------------------------------------------------------------
provider "aws" {}

# ----------------------------------------------------------------------------------------------
# Terraform Settings
# ----------------------------------------------------------------------------------------------
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "wwalpha"

    workspaces {
      name = "aws-iot-lab"
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Storage
# ----------------------------------------------------------------------------------------------
module "storage" {
  depends_on = [    random_id.this  ]
  source       = "./storage"
  project_name = local.project_name
  suffix       = local.suffix
}

# ----------------------------------------------------------------------------------------------
# Security Module
# ----------------------------------------------------------------------------------------------
# module "security" {
#   source          = "./security"
#   project_name_uc = local.project_name_uc
# }

# ----------------------------------------------------------------------------------------------
# Iot Module
# ----------------------------------------------------------------------------------------------
# module "iot_devices" {
#   depends_on = [
#     module.security
#   ]

#   source       = "./device"
#   project_name = local.project_name
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
# module "datalake" {
#   depends_on = [
#     module.security
#   ]

#   source            = "./datalake"
#   project_name      = local.project_name
#   firehose_role_arn = module.security.firehose_role_arn_datalake
# }

# ----------------------------------------------------------------------------------------------
# Databases
# ----------------------------------------------------------------------------------------------
# module "database" {
#   source       = "./database"
#   project_name = local.project_name
# }

# ----------------------------------------------------------------------------------------------
# App
# ----------------------------------------------------------------------------------------------
# module "app" {
#   source                                = "./app"
#   project_name                          = local.project_name
#   kinesis_firehose_name                 = module.datalake.kinesis_firehose_name
#   iot_rule_role_arn_status              = module.security.iot_role_arn_status
#   lambda_role_arn_kinesis_stream_events = module.security.lambda_role_arn_kinesis_stream_events
#   dynamodb_table_name_device_status     = module.database.dynamodb_table_name_device_status
# }
