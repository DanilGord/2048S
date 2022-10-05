[
    {
      "name": "${app_name}-${env}-app",
      "image": "${app_image}",
      "cpu": ${task_cpu},
      "memory": ${task_memory},
      "networkMode": "awsvpc",
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/log-group-app",
            "awslogs-region": "${aws_region}",
            "awslogs-stream-prefix": "ecs"
          }
      },

      "portMappings": [
        {
          "containerPort": ${app_port},
          "hostPort": ${app_port}
        }
      ]
      
      "environment": [
      {
        "name": "VERSION",
        "value": "${image_tag}"
      }
    ]
    }
  ]
