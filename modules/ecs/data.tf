data "template_file" "app" {
  template = file("${path.module}/${var.task_definition}")

  vars = {
    app_image   = local.app_image
    app_port    = var.app_port
    task_cpu    = var.task_cpu
    task_memory = var.task_memory
    aws_region  = var.aws_region
    app_name    = var.app_name
    env         = var.env
    image_tag   = var.image_tag
  }
}
