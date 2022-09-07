variable "aws_region" {
  default = ""
  type    = string
}

variable "subnet_count" {
  default = ""
}

variable "app_name" {
  type = string
}

variable "app_count" {
  default = ""
}

variable "availability_count" {
  default = ""
}

variable "cidr" {
  description = "The CIDR block for the VPC. Default value is a valid CIDR, but not acceptable by AWS and should be overridden"
  type        = string
  default     = "0.0.0.0/0"
}
# variable "common_tags" {
#
#   description = "Common Tags to apply to all resources"
#   type        = map(any)
#   default = {
#     Project     = "2048_demo3"
#     Environment = "dev"
#   }
# }
