variable "aws_region" {
  default = ""
  type    = string
}

variable "remote_state_bucket" {}

variable "aws_profile" {
  type = string
}

variable "app_name" {
  type = string
}

variable "env" {
  default = ""
  type    = string
}

locals {
  repository_name = format("%s-%s", var.app_name, var.env)
}
