# ----------------------------------------------------------------------------------------------
# Amazon S3 Bucket - Materials
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "materials" {
  bucket = local.bucket_name_materials
}

# ----------------------------------------------------------------------------------------------
# Amazon S3 Bucket Versioning - Materials
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket_versioning" "materials" {
  bucket = aws_s3_bucket.materials.id

  versioning_configuration {
    status = "Enabled"
  }
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

# ----------------------------------------------------------------------------------------------
# S3 Object - Lambda module
# ----------------------------------------------------------------------------------------------
resource "aws_s3_object" "libraries_dynamodb" {
  bucket = aws_s3_bucket.materials.id
  key    = "libraries/dynamodb.zip"
  source = data.archive_file.lambda_module.output_path

  lifecycle {
    ignore_changes = [
      etag
    ]
  }
}
