resource "aws_elastic_beanstalk_application" "app_beanstalk" {
  name        = var.nome_ambiente
  description = "aplicacao-de-${var.nome_ambiente}"
}

resource "aws_elastic_beanstalk_environment" "ambiente_beanstalk" {
  name                = var.nome_ambiente
  application         = aws_elastic_beanstalk_application.app_beanstalk.name
  solution_stack_name = "64bit Amazon Linux 2 v3.6.0 running Docker"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = var.maquina
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = var.maxSize
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = aws_iam_instance_profile.perfil.name
  }
}

resource "aws_elastic_beanstalk_application_version" "default" {
  depends_on = [
    aws_elastic_beanstalk_application.app_beanstalk,
    aws_elastic_beanstalk_environment.ambiente_beanstalk,
    aws_s3_object.docker
  ]
  name = var.nome_ambiente
  application = var.nome_ambiente
  description = "aplicacao-de-${var.nome_ambiente}"
  bucket = aws_s3_bucket.beanstalk_deploys.id
  key = aws_s3_object.docker.id
}
