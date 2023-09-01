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

## 🛠️ Comandos específicos neste projeto para execução
`cd env/prod`
`terraform init`
`terraform apply`

### Criar imagem (igual feito no curso anterior):
`cd clientes-leo-api`
`docker build . -t producao:v1`
`docker tag 99z99z99z999 999999999999.dkr.ecr.us-east-2.amazonaws.com/producao:v1`

### Login:
`aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 999999999999.dkr.ecr.us-east-2.amazonaws.com`

### subir imagem:
`docker push 999999999999.dkr.ecr.us-east-2.amazonaws.com/producao:v1`

### Compactação do Dockerrun.aws.json:
`cd env/prod`
`zip -r producao.zip . -i Dockerrun.aws.json`

### Atualização do ambiente para a ultima versão de produção:
`aws elasticbeanstalk update-environment --environment-name producao --version-label producao`