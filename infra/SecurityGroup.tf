resource "aws_security_group" "alb_public" {
  name        = "alb_ECS_public"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "tcp_alb_pub_in" {
  type              = "ingress"
  from_port         = 8000
  to_port           = 8000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
# ipv6_cidr_blocks  = [aws_vpc.example.ipv6_cidr_block]
  security_group_id = aws_security_group.alb_public.id
}

resource "aws_security_group_rule" "tcp_alb_pub_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_public.id
}

resource "aws_security_group" "alb_private" {
  name        = "alb_ECS_private"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "tcp_alb_priv_in" {
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  source_security_group_id = aws_security_group.alb_public.id
  security_group_id = aws_security_group.alb_private.id
}

resource "aws_security_group_rule" "tcp_alb_priv_out" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.alb_private.id
}