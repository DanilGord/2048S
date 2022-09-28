locals {
  state_prefix      = "terraform"
  env               = "dev"
  app_name          = "image-2048s"
  aws_profile       = "default"
  aws_account       = "979378082445"
  aws_region        = "eu-north-1"
  cidr              = "10.0.0.0/16"
  image_tag         = "faadfbdb59101303b57246cf776a6bed73fcec71"
  repo_url          = "https://github.com/DanilGord/2048S"
  branch_pattern    = "^refs/heads/develop$"
  git_trigger_event = "PUSH"
  app_count         = 1
  task_cpu          = "512"
  task_memory       = "1024"
  app_port          = "3000"
  task_definition   = "task_definition.json.tpl"
}

inputs = {
  remote_state_bucket = format("%s-%s-%s-%s", local.state_prefix, local.app_name, local.env, local.aws_region)
  env                 = local.env
  app_name            = local.app_name
  aws_profile         = local.aws_profile
  aws_account         = local.aws_account
  aws_region          = local.aws_region
  image_tag           = local.image_tag
  repo_url            = local.repo_url
  branch_pattern      = local.branch_pattern
  git_trigger_event   = local.git_trigger_event
  app_count           = local.app_count
  task_cpu            = local.task_cpu
  task_memory         = local.task_memory
  app_port            = local.app_port
  task_definition     = local.task_definition
}

remote_state {
  backend = "s3"

  config = {
    bucket         = format("%s-%s-%s-%s", local.state_prefix, local.app_name, local.env, local.aws_region)
    key            = format("%s/terraform.tfstate", path_relative_to_include())
    region         = local.aws_region
    encrypt        = true
    dynamodb_table = format("tflock-%s-%s-%s", local.env, local.app_name, local.aws_region)
    profile        = local.aws_profile
  }
}

# Version Locking
## tfenv exists to help developer experience for those who use tfenv
## it will automatically download and use this terraform version

generate "tfenv" {
  path              = ".terraform-version"
  if_exists         = "overwrite"
  disable_signature = true

  contents = <<EOF
0.14.7
EOF
}

terraform_version_constraint = "0.14.7"

terragrunt_version_constraint = ">= 0.26.7"

terraform {
  after_hook "remove_lock" {
    commands = [
      "apply",
      "console",
      "destroy",
      "import",
      "init",
      "plan",
      "push",
      "refresh",
    ]

    execute = [
      "rm",
      "-f",
      "${get_terragrunt_dir()}/.terraform.lock.hcl",
    ]

    run_on_error = true
  }
}
