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
  source = "./security"
}

# ----------------------------------------------------------------------------------------------
# Iot Module
# ----------------------------------------------------------------------------------------------
module "iot_devices" {
  depends_on = [
    module.security
  ]

  source                = "./device"
  lambda_basic_role_arn = module.security.lambda_basic_role_arn
}
