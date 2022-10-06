terraform {
  source = "../../../modules//codebuild"
}

include {
  path = find_in_parent_folders()
}

locals {
  secrets = read_terragrunt_config(find_in_parent_folders("secrets.hcl"))
}

dependency "ecr" {
  config_path = "../ecr"
  skip_outputs = true
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
      vpc_id             = "vpc-000000000000"
      private_subnets_id = ["subnet-00000000000", "subnet-11111111111"]
  }
}

inputs = merge(
  local.secrets.inputs,
  {
    vpc_id = dependency.vpc.outputs.vpc_id
    private_subnets_id = dependency.vpc.outputs.private_subnets_id
    build_spec_file = "provider/dev/buildspec.yml"
  }
)
