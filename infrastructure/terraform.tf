terraform {
  required_version = "~> 1.9.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.73.0"
    }
    time = {
      source  = "hashicorp/time"
      version = "0.12.1"
    }
  }

  backend "s3" {
    bucket = "terraform-state-store-barebones-joe"
    region = "eu-west-2"
  }
}
