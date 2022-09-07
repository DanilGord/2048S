[
    {
      "name": "${app_name}-app",
      "image": "979378082445.dkr.ecr.eu-north-1.amazonaws.com/image-2048s:50f6180f7b4beedc8324d758b8e13a190dc0e843",
      "cpu": ${task_cpu},
      "memory": ${task_memory},
      "networkMode": "awsvpc",
      "logConfiguration": {
          "logDriver": "awslogs",
          "options": {
            "awslogs-group": "/ecs/${app_name}-app",
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
    }
  ]
