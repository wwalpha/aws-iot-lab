# output "demo" {
#   value = null_resource.python_local
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT Certificate Public Key
# # ----------------------------------------------------------------------------------------------
# output "iot_public_key" {
#   value     = aws_iot_certificate.this.public_key
#   sensitive = true
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT Certificate Private Key
# # ----------------------------------------------------------------------------------------------
# output "iot_private_key" {
#   value     = aws_iot_certificate.this.private_key
#   sensitive = true
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT Certificate CA PEM
# # ----------------------------------------------------------------------------------------------
# output "iot_ca_pem" {
#   value     = aws_iot_certificate.this.ca_pem
#   sensitive = true
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT certificate PEM
# # ----------------------------------------------------------------------------------------------
# output "iot_certificate_pem" {
#   value     = aws_iot_certificate.this.certificate_pem
#   sensitive = true
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT certificate ID
# # ----------------------------------------------------------------------------------------------
# output "iot_certificate_id" {
#   value = aws_iot_certificate.this.id
# }

# # ----------------------------------------------------------------------------------------------
# # AWS IoT Certificate Private Key
# # ----------------------------------------------------------------------------------------------
# output "provisioning_template" {
#   value = aws_iot_provisioning_template.fleet
# }
