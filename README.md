# Projeto Alura: iac-docker-aws-ecs

### Infraestrutura como código: Terraform, Docker e Elastic Container Service
Quinto curso da formação *Infraestrutura como código* da **Alura**, utilizando Terraform, Docker e Elastic Container Service da AWS.

## ✔️ Objetivos com este curso
- Aprender sobre permissões e permissionamento
- Saiber como colocar uma aplicação com docker no ECS
- Entender o que é o Elastic Container Service
- Configurar um repositorio de imagens Docker na AWS
- Usar containers no cloud
- Conheçer o que é uma Virtual Private Cloud e suas vantagens
- Conheçer sobre os tipos de Load Balancers utilizados

## 🛠️ Comandos usados neste projeto para deploy em produção
### Comandos Terraform:
`cd env/prod`

`terraform init`

`terraform apply`

### Criar imagem docker (igual feito no curso anterior):
`cd clientes-leo-api`

`docker build . -t producao:v1`

`docker tag 88z88z88z888 999999999999.dkr.ecr.us-east-2.amazonaws.com/producao:v1`

### Login no ECR da AWS:
`aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 999999999999.dkr.ecr.us-east-2.amazonaws.com`

### Subir imagem docker renomeada:
`docker push 999999999999.dkr.ecr.us-east-2.amazonaws.com/producao:v1`

### Compactação do Dockerrun.aws.json:
`cd env/prod`

`zip -r producao.zip . -i Dockerrun.aws.json`

### Atualização do ambiente para a ultima versão de produção:
`aws elasticbeanstalk update-environment --environment-name producao --version-label producao`