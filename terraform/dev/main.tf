terraform {
  backend "s3" {
    bucket  = "demo-doppler-app"
    key     = "demo-doppler-app-terraformstatefile"
    region  = "ap-south-1"
    profile = "suraj"
  }

}

provider "aws" {
  region  = "ap-south-1"
}

