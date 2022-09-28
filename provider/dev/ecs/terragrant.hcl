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
      vpc_id             = "vpc-00000000000000000"
      public_subnets_id  = "subnet-00000000000000000"
      private_subnets_id = "subnet-00000000000000000"
  }
}

inputs = {
    ecr_url = dependency.ecr.outputs.ecr_repository_url
  }

inputs = {
    vpc_id = aws_vpc.vpc.id
  }

inputs = {
    public_subnets_id = aws_subnet.prod-subnet-public.*.id
  }

inputs = {
    private_subnets_id = aws_subnet.prod-subnet-private.*.id
  }
