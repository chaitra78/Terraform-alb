provider "aws" {
  region = "us-east-1"
}


terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"                # This means any version >= 5.0.0 and < 6.0.0
    }
  }
}


terraform {
  backend "s3" {
    bucket         = "my-s3-bucket-name-CR"       # Replace with your bucket name
    key            = "terraform.tfstate"          # Path inside the bucket
    region         = "us-east-1"                 # AWS region
    encrypt        = true                        # Encrypt the state file
  }
}



