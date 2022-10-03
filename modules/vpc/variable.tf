variable "aws_region" {
  default = ""
  type    = string
}

variable "subnet_count" {
  default = "2"
}

variable "app_name" {
  type = string
}

variable "aws_profile" {
  type = string
}

variable "app_count" {
  default = "1"
}

variable "availability_count" {
  default = "2"
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}

variable "remote_state_bucket" {}
# variable "environment" {
#   default = ""
#   type    = string
# }

# variable "common_tags" {
#
#   description = "Common Tags to apply to all resources"
#   type        = map(any)
#   default = {
#     Project     = "2048_demo3"
#     Environment = "dev"
#   }
# }
