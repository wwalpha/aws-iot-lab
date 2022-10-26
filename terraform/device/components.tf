# # ----------------------------------------------------------------------------------------------
# # Python Local
# # ----------------------------------------------------------------------------------------------
# resource "null_resource" "python_local" {
#   triggers = {
#     file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
#     lambda_arn       = "${aws_lambda_function.iot_python_local.arn}:${aws_lambda_function.iot_python_local.version}"
#     version          = "1.0.4"
#   }

#   provisioner "local-exec" {
#     when    = create
#     command = "sh ${path.module}/scripts/create_components.sh"

#     environment = {
#       LAMBDA_ARN        = self.triggers.lambda_arn
#       COMPONENT_NAME    = "com.greengrass.python.local"
#       COMPONENT_VERSION = self.triggers.version
#       EVENT_TOPIC       = "local/python"
#       EVENT_TYPE        = "PUB_SUB"
#       REGION            = local.region
#       ACCOUNT_ID        = local.account_id
#     }
#   }
# }

# # ----------------------------------------------------------------------------------------------
# # Python Remote
# # ----------------------------------------------------------------------------------------------
# resource "null_resource" "python_core" {
#   depends_on = [null_resource.python_local]

#   triggers = {
#     file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
#     lambda_arn       = "${aws_lambda_function.iot_python_remote.arn}:${aws_lambda_function.iot_python_remote.version}"
#     version          = "1.0.0"
#   }

#   provisioner "local-exec" {
#     when    = create
#     command = "sh ${path.module}/scripts/create_components.sh"

#     environment = {
#       LAMBDA_ARN        = self.triggers.lambda_arn
#       COMPONENT_NAME    = "com.greengrass.python.core"
#       COMPONENT_VERSION = self.triggers.version
#       EVENT_TOPIC       = "iot/python"
#       EVENT_TYPE        = "IOT_CORE"
#       REGION            = local.region
#       ACCOUNT_ID        = local.account_id
#     }
#   }
# }

# # ----------------------------------------------------------------------------------------------
# # Nodejs Local
# # ----------------------------------------------------------------------------------------------
# resource "null_resource" "nodejs_local" {
#   depends_on = [null_resource.python_core]

#   triggers = {
#     file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
#     lambda_arn       = "${aws_lambda_function.iot_nodejs_local.arn}:${aws_lambda_function.iot_nodejs_local.version}"
#     version          = "1.0.0"
#   }

#   provisioner "local-exec" {
#     when    = create
#     command = "sh ${path.module}/scripts/create_components.sh"

#     environment = {
#       LAMBDA_ARN        = self.triggers.lambda_arn
#       COMPONENT_NAME    = "com.greengrass.nodejs.local"
#       COMPONENT_VERSION = self.triggers.version
#       EVENT_TOPIC       = "local/nodejs"
#       EVENT_TYPE        = "PUB_SUB"
#       REGION            = local.region
#       ACCOUNT_ID        = local.account_id
#     }
#   }
# }

# # ----------------------------------------------------------------------------------------------
# # Nodejs Remote
# # ----------------------------------------------------------------------------------------------
# resource "null_resource" "nodejs_core" {
#   depends_on = [null_resource.nodejs_local]

#   triggers = {
#     file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
#     lambda_arn       = "${aws_lambda_function.iot_nodejs_remote.arn}:${aws_lambda_function.iot_nodejs_remote.version}"
#     version          = "1.0.0"
#   }

#   provisioner "local-exec" {
#     when    = create
#     command = "sh ${path.module}/scripts/create_components.sh"

#     environment = {
#       LAMBDA_ARN        = self.triggers.lambda_arn
#       COMPONENT_NAME    = "com.greengrass.nodejs.core"
#       COMPONENT_VERSION = self.triggers.version
#       EVENT_TOPIC       = "iot/nodejs"
#       EVENT_TYPE        = "IOT_CORE"
#       REGION            = local.region
#       ACCOUNT_ID        = local.account_id
#     }
#   }
# }

