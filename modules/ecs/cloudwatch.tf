resource "aws_cloudwatch_log_group" "log_group" {
  name              = "/ecs/log-group-app"
  retention_in_days = 30

  tags = {
    Name = "log-group-app"
  }
}

resource "aws_cloudwatch_log_stream" "log_stream" {
  name           = "${var.app_name}-${var.env}-log-stream"
  log_group_name = aws_cloudwatch_log_group.log_group.name

  tags = {
    Name = "log-stream"
  }
}
