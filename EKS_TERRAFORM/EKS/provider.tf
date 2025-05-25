terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" { #need to create manually or use tf in AWS, then use here
<<<<<<< HEAD
    bucket         = "fss-fss-Retail-App_kubernetes-project" 
=======
    bucket         = "fss-fss-retail-app-kubernetes-project" 
>>>>>>> 04bf784 (Clahan fss repo)
    key            = "eks-clahan.tfstate"
    region         = "us-east-1"
    # dynamodb_table = "vpc-module-locking"
    use_lockfile = true
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}  