data "aws_region" "current" {}

module "api" {
  source       = "./modules/api"
  domain_name  = var.domain_name
  name_postfix = local.name_postfix
  common_tags  = var.common_tags
}

module "website" {
  source             = "./modules/website"
  domain_name        = var.domain_name
  domain_prefix      = var.domain_prefix
  environment        = var.environment
  name_postfix       = local.name_postfix
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

locals {
  env_file_content = <<EOF
VITE_REGION: ${data.aws_region.current.name}
VITE_COGNITO_USERPOOL_ID: ${module.api.cognito_userpool_id}
VITE_COGNITO_USERPOOL_CLIENT_ID: ${module.api.cognito_userpool_client_id}
VITE_GRAPHQL_API: ${module.api.appsync_api_url}
VITE_API_KEY: ${module.api.appsync_api_key}
EOF
}


resource "local_file" "config_file" {
  content  = local.env_file_content
  filename = "${path.module}/../apps/website/.env.${var.environment}"
}

output "bucket_name" {
  value = module.website.web_content_bucket.id
}
