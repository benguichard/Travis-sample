### TERRAFORM ###

terraform {
  backend "s3" {
    bucket = "bguichard-paris-bucket"
    key    = "demo/terraform/terraform.tfstate"
    region = "eu-west-3"
  }
}

### PROVIDER ###

provider "aws" {}
