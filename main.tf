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
        Sid       = "CURD_Object",
        Effect    = "Allow",
        Principal = "*",
        Action    = [
          "s3:GetObject",
          "s3:ListBucket",
          "s3:PutObject",
          "s3:DeleteObject",
        ],
        Resource  = [
          aws_s3_bucket.compass.arn,
          "${aws_s3_bucket.compass.arn}/*",
        ],
      },
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