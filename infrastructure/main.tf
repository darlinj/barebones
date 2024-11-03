module "api" {
  source      = "./modules/api"
  common_tags = var.common_tags
}

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

resource "local_file" "config_file" {
  content  = <<EOF
window.config = {
  COGNITO_USERPOOL_ID: "${module.api.cognito_userpool_id}",
  COGNITO_USERPOOL_CLIENT_ID: "${module.api.cognito_userpool_client_id}",
  GRAPHQL_API: "${module.api.appsync_api_url}",
  API_KEY: "${module.api.appsync_api_key}"
};
EOF
  filename = "${path.module}/../apps/website/public/config.js.${var.environment}"
}

resource "aws_s3_object" "config_file" {
  bucket = module.website.web_content_bucket.id
  key    = "config.js"
  source = "${path.module}/../apps/website/public/config.js.${var.environment}"
  #   etag         = filemd5("${path.module}/../apps/website/public/config.js.${var.environment}")
  content_type = "application/javascript"
  metadata = {
    content_type = "application/javascript"
  }
  depends_on = [local_file.config_file]
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
  }

}
