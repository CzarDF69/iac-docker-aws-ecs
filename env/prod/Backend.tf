terraform {
  backend "s3" {
    bucket = "vcmundoafora.com.br"
    key    = "app/prod/iac-docker-aws-ecs.tfstate"
    region = "us-east-2"
  }
}