provider "aws" {
  region = "eu-west-2"
}

provider "aws" {
  alias  = "acm-provider"
  region = "us-east-1"
}
