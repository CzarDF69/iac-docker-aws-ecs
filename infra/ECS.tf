module "ecs" {
  source = "terraform-aws-modules/ecs/aws"

  cluster_name = "ecs-${var.nome_ambiente}"

  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        weight = 2
        base   = 1
      }
    }
  }

  tags = {
    Environment = var.nome_ambiente
    Project     = "Terraform"
  }
}

resource "aws_ecs_task_definition" "Django-API" {
  family                   = "Django-API"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  execution_role_arn       = aws_iam_role.cargo.arn
  container_definitions    = jsonencode([
    {
      name      = var.nome_ambiente
      image     = "444762586881.dkr.ecr.us-east-2.amazonaws.com/${var.nome_ambiente}:${var.versao}"
      cpu       = 256
      memory    = 512
      essential = true
      portMappings = [
        {
          containerPort = 8000
          hostPort      = 8000
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "Django-API" {
  name            = "Django-API"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.Django-API.arn
  desired_count   = 2
  depends_on      = [aws_iam_role_policy.policy]

  load_balancer {
    target_group_arn = aws_lb_target_group.alvo.arn
    container_name   = var.nome_ambiente
    container_port   = 8000
  }

  network_configuration {
    subnets = module.vpc.private_subnets
    security_groups = [aws_security_group.alb_private.id]
  }

  capacity_provider_strategy {
    capacity_provider = "FARGATE"
    weight = 1
  }
}