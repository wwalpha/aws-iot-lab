# ----------------------------------------------------------------------------------------------
# Amazon S3 - Data lake
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket" "data_lake" {
  bucket = local.bucket_name_data_lake
}

# ----------------------------------------------------------------------------------------------
# Amazon S3 LifeCycle - Data lake
# ----------------------------------------------------------------------------------------------
resource "aws_s3_bucket_lifecycle_configuration" "data_lake" {
  bucket = aws_s3_bucket.data_lake.id

  rule {
    id     = "allfiles"
    status = "Enabled"

    expiration {
      days = 30
    }
  }
}
