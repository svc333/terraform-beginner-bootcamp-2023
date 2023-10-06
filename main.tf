terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.5.1"
    }
     aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

provider "random" {
  # Configuration options
}

resource "random_string" "bucket_name" {
  length           = 63
  special          = false
  lower            = true
  upper            = false
}

output "random_bucket_name_result" {
  value = random_string.bucket_name.result
}

resource "aws_s3_bucket" "example" {
  bucket = random_string.bucket_name.result

  tags = {
    Environment = "test"
  }
}

terraform {
  cloud {
    organization = "scal"

    workspaces {
      name = "terra-house-1"
    }
  }
}