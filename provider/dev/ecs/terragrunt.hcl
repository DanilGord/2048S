terraform {
  source = "../../../modules//ecs"
}

include {
  path = find_in_parent_folders()
}

dependency "ecr" {
    config_path = "../ecr"
    mock_outputs = {
      ecr_url = "000000000000.dkr.ecr.eu-north-1.amazonaws.com/image"
  }
}

dependency "vpc" {
    config_path = "../vpc"
    mock_outputs = {
      vpc_id             = "vpc-000000000000"
      private_subnets_id = ["subnet-00000000000", "subnet-11111111111"]
      public_subnets_id  = ["subnet-22222222222", "subnet-33333333333"]
  }
}

inputs = {
    ecr_url            = "979378082445.dkr.ecr.eu-north-1.amazonaws.com/image-2048s"
    vpc_id             = dependency.vpc.outputs.vpc_id
    private_subnets_id = dependency.vpc.outputs.private_subnets_id
    public_subnets_id  = dependency.vpc.outputs.public_subnets_id
  }
