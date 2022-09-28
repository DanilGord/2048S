# provider "aws" {
#   region = var.aws_region
# }
#
# terraform {
#   backend "s3" {
#     bucket = "tf-state-20048s"
#     key    = "terraform-states_vpc/terraform.tfstate"
#     region = "eu-north-1"
#   }
#   required_providers {
#     aws = {
#       version = "~> 3.35"
#     }
#   }
# }
#
# module "vpc" {
#   source = "./vpc"
#
#   cidr               = var.cidr
#   subnet_count       = var.subnet_count
#   app_name           = var.app_name
#   app_count          = var.app_count
#   availability_count = var.availability_count
# }
#
#
# # module "ecr" {
# #   source = "./modules/ecr"
# # }
#
# module "ecs" {
#   source             = "./ecs"
#   vpc_id             = module.vpc.vpc_id
#   private_subnets_id = module.vpc.private_subnets_id
#   public_subnets_id  = module.vpc.public_subnets_id
#   ecr_url            = var.ecr_url
#   task_cpu           = var.task_cpu
#   task_memory        = var.task_memory
#   environment        = var.environment
#   app_name           = var.app_name
#   # image_tag          = var.image_tag
#   app_port          = var.app_port
#   app_count         = var.app_count
#   health_check_path = var.health_check_path
#   task_definition   = var.task_definition
#   app_image         = var.app_image
#   depends_on        = [module.vpc]
# }
