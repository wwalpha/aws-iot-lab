# ----------------------------------------------------------------------------------------------
# Amazon S3 Bucket - Materials
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "materials" {
  bucket = local.bucket_name_materials
}

# ----------------------------------------------------------------------------------------------
# S3 Object - Lambda module
# ----------------------------------------------------------------------------------------------
resource "aws_s3_object" "lambda_module" {
  bucket = aws_s3_bucket.materials.id
  key    = "lambda/default.zip"
  source = data.archive_file.lambda_module.output_path

  lifecycle {
    ignore_changes = [
      etag
    ]
  }
}
