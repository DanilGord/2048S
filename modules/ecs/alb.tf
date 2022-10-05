resource "aws_alb" "alb_main" {
  name            = "${var.app_name}-${var.env}-alb"
  subnets         = var.public_subnets_id
  security_groups = [aws_security_group.alb_sec.id]
}

resource "aws_alb_target_group" "app" {
  name        = "${var.app_name}-${var.env}-alb-tg"
  port        = var.app_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "2"
    unhealthy_threshold = "2"
    timeout             = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    path                = var.health_check_path
  }
}

resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = aws_alb.alb_main.id
  port              = var.app_port
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.app.id
    type             = "forward"
  }
}
