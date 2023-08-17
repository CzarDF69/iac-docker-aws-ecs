module "prod" {
    source = "../../infra"

    nome_ambiente = "producao"
    sigla_ambiente = "prd"
    versao = "v01"
}

output "IP_alb" {
    value = module.prod.IP
}
