# S3 bucket for website.
resource "aws_s3_bucket" "www_bucket" {
  bucket = local.bucket_name
  tags   = var.common_tags
}
data "aws_s3_bucket" "content_bucket" {
  bucket = aws_s3_bucket.www_bucket.bucket
}

resource "aws_s3_bucket_cors_configuration" "example" {
  bucket = data.aws_s3_bucket.content_bucket.bucket
  cors_rule {
    allowed_headers = ["Authorization", "Content-Length"]
    allowed_methods = ["GET", "POST"]
    allowed_origins = ["https://$(var.domain_prefix}.${var.domain_name}"]
    max_age_seconds = 3000
  }
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "Origin access identity for S3 bucket"
}

resource "aws_s3_bucket_policy" "bucket-policy" {
  bucket = data.aws_s3_bucket.content_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${data.aws_s3_bucket.content_bucket.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "website-config" {
  bucket = data.aws_s3_bucket.content_bucket.bucket
  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "404.jpeg"
  }
}
