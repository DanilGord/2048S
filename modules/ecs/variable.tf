variable "aws_region" {
  default = "eu-north-1"
  type    = string
}

variable "subnet_count" {
  default = ""
}

variable "app_name" {
  default = ""
  type    = string
}

variable "env" {
  default = ""
  type    = string
}

variable "image_tag" {
  default = ""
  type    = string
}

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

variable "task_definition" {
  default = "task_definition.json.tpl"
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

variable "ecr_url" {
  default = ""
  type    = string
}

variable "vpc_id" {
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
  app_image = format("%s:%s", var.ecr_url, var.image_tag)
}


variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  default     = "TaskRole"
}
