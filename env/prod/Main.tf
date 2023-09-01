module "prod" {
    source = "../../infra"

    regiao = var.regiao
    nome_ambiente = "producao"
    sigla_ambiente = "prod"
    versao = "v01"
    maquina = "t2.micro"
    maxSize = 2
}

output "IP_alb" {
    value = module.prod.IP
}
