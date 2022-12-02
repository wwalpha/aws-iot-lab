# # ----------------------------------------------------------------------------------------------
# # AWS IoT Certificate
# # ----------------------------------------------------------------------------------------------
# resource "aws_iot_certificate" "this" {
#   active = true
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT Policy - Certificate
# # ----------------------------------------------------------------------------------------------
# resource "aws_iot_policy" "cert" {
#   name = "PubSubToAnyTopic"

#   policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": [
#         "iot:Connect",
#         "iot:Publish",
#         "iot:Receive",
#         "iot:Subscribe"
#       ],
#       "Effect": "Allow",
#       "Resource": "*"
#     }
#   ]
# }
# EOF
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT Policy Attachment - Certificate
# # ----------------------------------------------------------------------------------------------
# resource "aws_iot_policy_attachment" "cert" {
#   policy = aws_iot_policy.cert.name
#   target = aws_iot_certificate.this.arn
# }
