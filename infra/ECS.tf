module "ecs" {
  source = "terraform-aws-modules/ecs/aws"
  name = "ecs_${var.sigla_ambiente}"
  container_insights = true
  capacity_providers = ["FARGATE"]
  default_capacity_provider_strategy = [
    {
      capacity_provider = "FARGATE"
    }
  ]
  tags = {
    Environment = var.nome_ambiente
  }
}

resource "aws_ecs_task_definition" "Django-API" {
  family                   = "Django-API"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.cargo.arn
  container_definitions    = jsonencode(
    [
        {
            "name"= var.nome_ambiente
            "image"= "444762586881.dkr.ecr.us-east-2.amazonaws.com/${var.nome_ambiente}:${var.versao}"
            "cpu"= 256
            "memory"= 512
            "essential"= true
            "portMappings"= [
                {
                    "containerPort"= 8000
                    "hostPort"= 8000
                }
            ]
        }
    ]
  )
}
