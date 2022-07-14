# ----------------------------------------------------------------------------------------------
# AWS IoT Certificate Public Key
# ----------------------------------------------------------------------------------------------
output "cert_public_key" {
  value     = aws_iot_certificate.this.public_key
  sensitive = true
}

# ----------------------------------------------------------------------------------------------
# AWS IoT Certificate Private Key
# ----------------------------------------------------------------------------------------------
output "cert_private_key" {
  value     = aws_iot_certificate.this.private_key
  sensitive = true
}
