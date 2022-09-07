resource "aws_ecr_repository" "aws_ecr" {
  name = local.repository_name
}
