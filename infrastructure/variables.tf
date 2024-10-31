variable "domain_prefix" {
  type        = string
  description = "The prefix of the domain for the website"
}

variable "environment" {
  type        = string
  description = "The environment that we are deploying to.  REPLACE WITH WORKSPACE"
}

variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}
