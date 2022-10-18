data "aws_region" "current" {}

resource "aws_security_group" "codebuild_sg" {
  name        = "allow_vpc_connectivity"
  description = "Allow Codebuild connectivity to all the resources within our VPC"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





resource "null_resource" "import_source_credentials" {


  triggers = {
    github_oauth_token = var.github_token
  }

  provisioner "local-exec" {
    command = <<EOF
      aws --region ${data.aws_region.current.name} codebuild import-source-credentials \
                                                             --token ${var.github_token} \
                                                             --server-type GITHUB \
                                                             --auth-type PERSONAL_ACCESS_TOKEN
EOF
  }
}

resource "aws_codebuild_project" "project" {
  name           = local.codebuild_project_name
  service_role   = aws_iam_role.app_container_codebuild_role.arn
  badge_enabled  = false
  build_timeout  = 100
  queued_timeout = 480
  depends_on     = [null_resource.import_source_credentials]

  artifacts {
    type = "NO_ARTIFACTS"
  }

  # cache {
  #   type     = "S3"
  #   location = aws_s3_bucket.example.bucket
  # }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/standard:4.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = true

    environment_variable {
      name  = "CI"
      value = "true"
    }
  }

  source {
    buildspec           = var.build_spec_file
    type                = "GITHUB"
    location            = var.repo_url
    git_clone_depth     = 1
    report_build_status = "true"
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.private_subnets_id
    security_group_ids = [aws_security_group.codebuild_sg.id]
  }
}

resource "aws_codebuild_webhook" "develop_webhook" {
  project_name = aws_codebuild_project.project.name

  filter_group {
    filter {
      type    = "EVENT"
      pattern = var.git_trigger_event
    }

    filter {
      type    = "HEAD_REF"
      pattern = var.branch_pattern
    }
  }
}
