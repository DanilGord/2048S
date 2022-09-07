resource "aws_ecs_cluster" "ecs_main" {
  name = "${var.app_name}-${var.environment}-ecs"
  tags = {
    Name = "${var.app_name}-${var.environment}-ecs"
  }
}

resource "aws_ecs_task_definition" "ecs_app" {
  family                   = "${var.app_name}-${var.environment}-task"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = var.task_cpu
  memory                   = var.task_memory
  container_definitions    = data.template_file.app.rendered
}

resource "aws_ecs_service" "main" {
  name            = "${var.app_name}-${var.environment}-ecs-service"
  cluster         = aws_ecs_cluster.ecs_main.id
  task_definition = aws_ecs_task_definition.ecs_app.arn
  desired_count   = var.app_count
  launch_type     = "FARGATE"

  network_configuration {
    security_groups  = [aws_security_group.ecs_sec_task.id]
    subnets          = var.private_subnets_id
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.app.id
    container_name   = "${var.app_name}-app"
    container_port   = var.app_port
  }

  #depends_on = [aws_alb_listener.app_listener, aws_iam_role_policy_attachment.ecs_task_execution_role, aws_route_table_association.private]
  depends_on = [aws_alb_listener.app_listener]
}
