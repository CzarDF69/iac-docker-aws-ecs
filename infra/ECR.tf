resource "aws_ecr_repository" "repositorio" {
  name                 = var.nome_ambiente
  image_tag_mutability = "MUTABLE"
}