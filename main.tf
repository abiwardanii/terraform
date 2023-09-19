terraform {
  cloud {
    organization = "antikode"
    workspaces {
      name = "s3-test"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-1"
}

resource "aws_s3_bucket" "compass" {
  bucket = "compass-ecom-bucket"

  tags = {
    Name        = "Compass"
    Project = "Compass"
  }
}