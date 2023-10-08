terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.19.0"
    }
  }
# provider "aws" {
#   # Configuration options - use assume role in future
# }



#   cloud {
#     organization = "scal"

#     workspaces {
#       name = "terra-house-1"
#     }
#   }
}