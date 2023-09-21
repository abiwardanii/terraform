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

resource "aws_ami_from_instance" "compass" {
  name               = "compass_ami"
  source_instance_id = "i-07977d7ede714858e"
  tags = {
    Name = "compass_fe"
    Project = "Compass"
  }
}
