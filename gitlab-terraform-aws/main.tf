terraform {
  required_providers {
    aws = {
      version = "~> 2.0"
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
  token = var.token
}

terraform {
  backend "http" {
    
  }
}
