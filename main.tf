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

//S3 Bucket
resource "aws_s3_bucket" "compass" {
  bucket = "compass-ecom-bucket"

  tags = {
    Name        = "Compass"
    Project     = "Compass"
  }
}

//CRUD Policy
resource "aws_s3_bucket_policy" "compass_policy" {
  bucket = aws_s3_bucket.compass.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::compass-ecom-bucket/*"
        },
        {
            "Sid": "AllowUserPutObject",
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::779996914529:user/compass"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::compass-ecom-bucket/*"
        }
    ],
  })
}
//Block access public
resource "aws_s3_bucket_public_access_block" "compass" {
  bucket = aws_s3_bucket.compass.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}