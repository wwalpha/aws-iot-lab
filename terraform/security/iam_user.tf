# ----------------------------------------------------------------------------------------------
# AWS IAM User for Greengrass Provision
# ----------------------------------------------------------------------------------------------
resource "aws_iam_user" "greengrass_provision" {
  name = "${var.project_name_uc}_Greengrass_Provision"
  path = "/system/"
}

# ----------------------------------------------------------------------------------------------
# AWS IoT Greengrass provision role policy
# ----------------------------------------------------------------------------------------------
resource "aws_iam_user_policy" "greengrass_provision" {
  name = "greengrass_provision"
  user = aws_iam_user.greengrass_provision.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "CreateTokenExchangeRole",
        Effect = "Allow"
        Action = [
          "iam:AttachRolePolicy",
          "iam:CreatePolicy",
          "iam:CreateRole",
          "iam:GetPolicy",
          "iam:GetRole",
          "iam:PassRole"
        ],
        Resource = [
          "arn:aws:iam::${local.account_id}:role/GreengrassV2TokenExchangeRole",
          "arn:aws:iam::${local.account_id}:policy/GreengrassV2TokenExchangeRoleAccess"
        ]
      },
      {
        Sid    = "CreateIoTResources",
        Effect = "Allow"
        Action = [
          "iot:AddThingToThingGroup",
          "iot:AttachPolicy",
          "iot:AttachThingPrincipal",
          "iot:CreateKeysAndCertificate",
          "iot:CreatePolicy",
          "iot:CreateRoleAlias",
          "iot:CreateThing",
          "iot:CreateThingGroup",
          "iot:DescribeEndpoint",
          "iot:DescribeRoleAlias",
          "iot:DescribeThingGroup",
          "iot:GetPolicy"
        ],
        Resource = ["*"]
      },
      {
        Sid    = "DeployDevTools",
        Effect = "Allow",
        Action = [
          "greengrass:CreateDeployment",
          "iot:CancelJob",
          "iot:CreateJob",
          "iot:DeleteThingShadow",
          "iot:DescribeJob",
          "iot:DescribeThing",
          "iot:DescribeThingGroup",
          "iot:GetThingShadow",
          "iot:UpdateJob",
          "iot:UpdateThingShadow"
        ],
        Resource = ["*"]
      }
    ]
  })
}
