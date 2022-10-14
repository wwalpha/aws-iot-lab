# ----------------------------------------------------------------------------------------------
# AWS IAM Role - Kinesis Firehose
# ----------------------------------------------------------------------------------------------
resource "aws_iam_role" "kinesis_firehose" {
  name               = "${var.project_name_uc}_FirehoseRole"
  assume_role_policy = data.aws_iam_policy_document.kinesis.json

  lifecycle {
    create_before_destroy = false
  }
}
