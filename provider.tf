terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }

  cloud {
    organization = "cloud-talents"

    workspaces {
      name = "Network"
    }
  }
}


