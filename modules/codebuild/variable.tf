variable "aws_region" {
  description = "aws region"
}

variable "aws_profile" {
  description = "aws profile"
}

variable "aws_account" {
  description = "aws profile"
}

variable "remote_state_bucket" {}

variable "repo_url" {
  description = "https://github.com/DanilGord/2048S.git"
}

variable "github_token" {
  description = "Github OAuth token with repo access permissions"
}

variable "env" {
  type = string
}

variable "app_name" {
  type = string
}

variable "build_spec_file" {
  default = "buildspec.yml"
}

variable "vpc_id" {
  type = string
}

variable "private_subnets_id" {
  type = list(any)
}

variable "branch_pattern" {}

variable "git_trigger_event" {}

locals {
  codebuild_project_name = "${var.app_name}-${var.environment}"
  description            = "Codebuild for ${var.app_name} environment ${var.environment}"
}
