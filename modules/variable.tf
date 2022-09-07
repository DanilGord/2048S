#for vpc
variable "aws_region" {
  default = ""
  type    = string
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "0.0.0.0/0"
}

variable "subnet_count" {
  default = ""
}

#for ECS

variable "ecr_url" {
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

variable "app_image" {
  default = "979378082445.dkr.ecr.eu-north-1.amazonaws.com"
  #default = "image_2048S"
  type = string
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

variable "image_tag" {
  default = "test:0a43dd6ccfb31da19aeb21c034c71574f9f81f47"
  #default = "latest"
  type = string
}

variable "task_definition" {
  default = ""
}

variable "app_count" {
  default = ""
}

variable "availability_count" {
  default = ""
}
