variable "aws_region" {
  type = string
}

variable "aws_profile" {
  description = "aws profile"
}

variable "remote_state_bucket" {
}

variable "app_name" {
  type = string
}

variable "app_enviroment" {
  type = string
}

locals {
  repository_name = format("%s-%s", var.app_name, var.environment)
}
