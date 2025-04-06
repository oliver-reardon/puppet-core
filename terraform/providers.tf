terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.74.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = merge(local.base_tags, {
      region = var.aws_region
    })
  }
}
