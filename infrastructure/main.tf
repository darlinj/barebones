module "website" {
  source             = "./modules/website"
  domain_name        = var.domain_name
  bucket_name        = "${var.domain_prefix}.${var.domain_name}"
  domain_prefix      = var.domain_prefix
  environment        = var.environment
  cloudfront_aliases = ["${var.domain_prefix}.${var.domain_name}"]
  common_tags        = var.common_tags
}

resource "aws_s3_object" "web_content" {
  for_each = fileset("../apps/website", "*")
  bucket   = module.website.web_content_bucket.id
  key      = each.value
  source   = "../apps/website/${each.value}"
  etag     = filemd5("../apps/website/${each.value}")
  metadata = {
    cache-control = each.value == "index.html" ? "no-cache" : ""
    content-type  = "text/html"
  }

}
