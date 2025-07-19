terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.97.0"  # Compatible with EKS module v20.x (<6.0.0)
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  #profile = "yekusdemo"
}

# Get current account details
data "aws_caller_identity" "current" {}

# VPC module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"  # This is the latest compatible version pulled earlier

  name = "keycloakharagro-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_vpn_gateway   = false

  tags = {
    Project = "keycloakharagro"
  }
}


/*
provider "aws" {
  region = "us-east-1"
  profile = "yekusdemo"
}

# create VPC

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "keycloakharagro-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
  single_nat_gateway = true

  tags = {
    Project = "keycloakharagro"
  }
}
*/