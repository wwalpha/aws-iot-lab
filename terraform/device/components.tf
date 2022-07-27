# ----------------------------------------------------------------------------------------------
# Python Local
# ----------------------------------------------------------------------------------------------
resource "null_resource" "python_local" {
  triggers = {
    file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
  }

  provisioner "local-exec" {
    when    = create
    command = "sh ${path.module}/scripts/create_components.sh"

    environment = {
      LAMBDA_ARN        = "${aws_lambda_function.iot_python_local.arn}:${aws_lambda_function.iot_python_local.version}"
      COPOMNENT_NAME    = "com.greengrass.python.local"
      COPOMNENT_VERSION = "1.0.4"
      EVENT_TOPIC       = "local/python"
      EVENT_TYPE        = "PUB_SUB"
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Python Remote
# ----------------------------------------------------------------------------------------------
resource "null_resource" "python_core" {
  depends_on = [null_resource.python_local]

  triggers = {
    file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
  }

  provisioner "local-exec" {
    when    = create
    command = "sh ${path.module}/scripts/create_components.sh"

    environment = {
      LAMBDA_ARN        = "${aws_lambda_function.iot_python_remote.arn}:${aws_lambda_function.iot_python_remote.version}"
      COPOMNENT_NAME    = "com.greengrass.python.core"
      COPOMNENT_VERSION = "1.0.0"
      EVENT_TOPIC       = "iot/python"
      EVENT_TYPE        = "IOT_CORE"
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Nodejs Local
# ----------------------------------------------------------------------------------------------
resource "null_resource" "nodejs_local" {
  depends_on = [null_resource.python_core]

  triggers = {
    file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
  }

  provisioner "local-exec" {
    when    = create
    command = "sh ${path.module}/scripts/create_components.sh"

    environment = {
      LAMBDA_ARN        = "${aws_lambda_function.iot_nodejs_local.arn}:${aws_lambda_function.iot_nodejs_local.version}"
      COPOMNENT_NAME    = "com.greengrass.nodejs.local"
      COPOMNENT_VERSION = "1.0.0"
      EVENT_TOPIC       = "local/nodejs"
      EVENT_TYPE        = "PUB_SUB"
    }
  }
}

# ----------------------------------------------------------------------------------------------
# Nodejs Remote
# ----------------------------------------------------------------------------------------------
resource "null_resource" "nodejs_core" {
  depends_on = [null_resource.nodejs_local]

  triggers = {
    file_content_md5 = md5(file("${path.module}/scripts/create_components.sh"))
  }

  provisioner "local-exec" {
    when    = create
    command = "sh ${path.module}/scripts/create_components.sh"

    environment = {
      LAMBDA_ARN        = "${aws_lambda_function.iot_nodejs_remote.arn}:${aws_lambda_function.iot_nodejs_remote.version}"
      COPOMNENT_NAME    = "com.greengrass.nodejs.core"
      COPOMNENT_VERSION = "1.0.0"
      EVENT_TOPIC       = "iot/nodejs"
      EVENT_TYPE        = "IOT_CORE"
    }
  }
}

