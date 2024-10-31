module "website" {
  source             = "./modules/website"
  domain_name        = var.domain_name
  bucket_name        = "${var.domain_prefix}.${var.domain_name}"
  domain_prefix      = var.domain_prefix
  environment        = var.environment
  cloudfront_aliases = ["${var.domain_prefix}.${var.domain_name}"]
  common_tags        = var.common_tags
}
