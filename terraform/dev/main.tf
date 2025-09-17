terraform {
  backend "s3" {
    bucket  = "demo-terraformstatefile"
    key     = "dev"
    region  = "us-east-1"
    profile = "suraj"
  }

}

provider "aws" {
  region  = "us-east-1"
  profile = "suraj"
}

