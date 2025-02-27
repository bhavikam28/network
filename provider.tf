terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

 backend "remote" {
    organization = "cloud-talents"

    workspaces {
      name = "Network"
    }
  }
}


