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


module "iot_devices" {
  source = "./device"

}
