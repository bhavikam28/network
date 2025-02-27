terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  cloud {
    organization = "cloud-talents"

    workspaces {
      name = "Network"
    }
  }
}


