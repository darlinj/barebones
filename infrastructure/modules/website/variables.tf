variable "environment" {
  type        = string
  description = "The environment that this is deploying to."
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "name_postfix" {
  type        = string
  description = "The postfix for naming resources"
}

variable "domain_prefix" {
  type        = string
  description = "The prefix for the website."
}

variable "cloudfront_aliases" {
  description = "Cloudfront aliases so that cloudfront knows which URLs it is fronting"
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}
