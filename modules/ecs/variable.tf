variable "aws_region" {
  default = "eu-north-1"
  type    = string
}

variable "subnet_count" {
  #default = 2
  default = ""
}

variable "app_name" {
  default = ""
  type    = string
}

variable "environment" {
  default = ""
  type    = string
}

# variable "app_image" {
#   # default = "979378082445.dkr.ecr.eu-north-1.amazonaws.com"
#   #default = "image_2048S"
#   type = string
# }

variable "task_cpu" {
  default = ""
}

variable "task_memory" {
  default = ""
}

variable "app_port" {
  default = ""
}

variable "health_check_path" {
  default = "/"
}

variable "image_tag" {
  default = "faadfbdb59101303b57246cf776a6bed73fcec71"
  #default = "latest"
  type = string
}

variable "task_definition" {
  default = ""
}

variable "app_count" {
  default = ""
}

variable "aws_profile" {
  type = string
}

variable "availability_count" {
  default = ""
}

variable "ecr_urll" {
  default = "979378082445.dkr.ecr.eu-north-1.amazonaws.com/image-2048s"
  type    = string
}

variable "vpc_id" {
  type = string
}

variable "ecr_url" {
  type = string
}

variable "private_subnets_id" {
  type = list(any)
}

variable "public_subnets_id" {
  type = list(any)
}

variable "remote_state_bucket" {}

locals {
  app_image = format("%s:%s", var.ecr_urll, var.image_tag)
}
