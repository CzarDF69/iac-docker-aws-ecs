resource "aws_lb" "alb" {
  name               = "ECS-Django"
  security_groups    = [aws_security_group.alb_public.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  tags = {
    Environment = var.nome_ambiente
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "8000"
  protocol          = "HTTP"
# ssl_policy        = "ELBSecurityPolicy-2016-08"
# certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alvo.arn
  }
}

resource "aws_lb_target_group" "alvo" {
  name        = "ECS-Django"
  port        = 8000
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = module.vpc.vpc_id
}

output "IP" {
  value = aws_lb.alb.dns_name
}