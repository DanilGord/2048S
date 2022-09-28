provider "aws" {
  region = var.aws_region
}

# terraform {
#   backend "s3" {
#     bucket = "s3-ecr-test"
#     key    = "terraform-states_ecr/terraform.tfstate"
#     region = "eu-north-1"
#   }
# }
