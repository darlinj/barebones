module "website" {
  source             = "./modules/website"
  domain_name        = var.domain_name
  bucket_name        = "${var.domain_prefix}.${var.domain_name}"
  domain_prefix      = var.domain_prefix
  environment        = var.environment
  cloudfront_aliases = ["${var.domain_prefix}.${var.domain_name}"]
  common_tags        = var.common_tags
}

locals {
  mime_types = {
    ".html" = "text/html"
    ".css"  = "text/css"
    ".js"   = "application/javascript"
    ".png"  = "image/png"
    ".svg"  = "image/svg+xml"
    ".jpg"  = "image/jpeg"
    ".jpeg" = "image/jpeg"
    ".gif"  = "image/gif"
  }
}

resource "aws_s3_object" "web_content" {
  for_each     = fileset("../apps/website/dist", "**")
  bucket       = module.website.web_content_bucket.id
  key          = each.value
  source       = "../apps/website/dist/${each.value}"
  etag         = filemd5("../apps/website/dist/${each.value}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
  metadata = {
    cache-control = each.value == "index.html" ? "no-cache" : ""
    content_type  = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
    # content-type  = "text/html"
  }

}
