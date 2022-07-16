# ----------------------------------------------------------------------------------------------
# AWS Role policy
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "iot_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["iot.amazonaws.com"]
    }
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Service Role
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "iot_fleet_provisioning" {
  name               = "IoTProvisioningServiceRole"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.iot_assume_role_policy.json
}

# ----------------------------------------------------------------------------------------------
# AWS Service Role Policy
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "iot_fleet_provisioning_registration" {
  role       = aws_iam_role.iot_fleet_provisioning.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSIoTThingsRegistration"
}

# ----------------------------------------------------------------------------------------------
# AWS Service Role Policy - Device
# ----------------------------------------------------------------------------------------------
data "aws_iam_policy_document" "device_policy" {
  statement {
    actions = [
      "iot:Subscribe",
      "iot:Connect"
    ]
    resources = ["*"]
  }
}

# ----------------------------------------------------------------------------------------------
# AWS Service Role Policy - Device
# ----------------------------------------------------------------------------------------------
resource "aws_iot_policy" "device_policy" {
  name   = "iot_fleet_device_policy"
  policy = data.aws_iam_policy_document.device_policy.json
}

# ----------------------------------------------------------------------------------------------
# AWS IoT Certificate
# ----------------------------------------------------------------------------------------------
resource "aws_iot_provisioning_template" "fleet" {
  name                  = "iot_lab_fleet"
  description           = "Iot Lab fleet template"
  enabled               = true
  provisioning_role_arn = aws_iam_role.iot_fleet_provisioning.arn

  template_body = jsonencode({
    Parameters = {
      SerialNumber = { Type = "String" }
    }

    Resources = {
      certificate = {
        Properties = {
          CertificateId = { Ref = "AWS::IoT::Certificate::Id" }
          Status        = "Active"
        }
        Type = "AWS::IoT::Certificate"
      }

      policy = {
        Properties = {
          PolicyName = aws_iot_policy.device_policy.name
        }
        Type = "AWS::IoT::Policy"
      }
    }
  })
}
