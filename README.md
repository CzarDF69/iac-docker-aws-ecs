# Resumo do projeto

### Curso de Infraestrutura como código: Terraform, Docker e Elastic Container Service
Quinto curso da formação Infraestrutura como código, utilizando Terraform, Docker e Elastic Container Service da AWS.

## ✔️ Objetivos com este curso
- Aprender sobre permissões e permissionamento
- Saiber como colocar uma aplicação com docker no ECS
- Entender o que é o Elastic Container Service
- Configurar um repositorio de imagens Docker na AWS
- Usar containers no cloud
- Conheçer o que é uma Virtual Private Cloud e suas vantagens
- Conheçer sobre os tipos de Load Balancers utilizados

## 🛠️ Comandos específicos usados neste projeto

#### Login
aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 444762586881.dkr.ecr.us-east-2.amazonaws.com

#### Criar novo mome da imagem
docker tag 88ea1e71d798 444762586881.dkr.ecr.us-east-2.amazonaws.com/producao:v1

#### subir imagem
docker push 444762586881.dkr.ecr.us-east-2.amazonaws.com/producao:v1

#### Compactação do Dockerrun.aws.json
zip -r producao.zip . -i Dockerrun.aws.json

#### AWS elasticbeanstalk
aws elasticbeanstalk update-environment --environment-name ambiente-producao --version-label ambiente-producao