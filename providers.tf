terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }

#   cloud {
#     organization = "scal"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
}

provider "random" {
  # Configuration options
}
provider "aws" {
  # Configuration options
}