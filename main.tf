terraform {
  cloud {
    organization = "your_org"
    workspaces {
      name = "test"
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
resource "aws_lightsail_key_pair" "lg_key_pair" {
  name = "name"
}
resource "aws_lightsail_instance" "test" {
  name              = "test"
  availability_zone = "ap-southeast-1a"
  blueprint_id      = "ubuntu_22_04"
  bundle_id         = "small_2_0"
  key_pair_name     = "test"
  tags = {
    Name = "name"
    Project = "project"
  }
}
