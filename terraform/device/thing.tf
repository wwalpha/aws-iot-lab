# ----------------------------------------------------------------------------------------------
# AWS IoT Thing group
# ----------------------------------------------------------------------------------------------
resource "aws_iot_thing_group" "this" {
  name = "${var.project_name}-raspberrypi"
}