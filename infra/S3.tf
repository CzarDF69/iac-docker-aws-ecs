resource "aws_s3_bucket" "beanstalk_deploys" {
    bucket = "vcma-deploy-${var.nome_ambiente}"
}

resource "aws_s3_object" "docker" {
    depends_on = [
        aws_s3_bucket.beanstalk_deploys
    ]

    bucket = aws_s3_bucket.beanstalk_deploys.id
    key = "${var.nome_ambiente}.zip"
    source = "${var.nome_ambiente}.zip"
    etag = filemd5("${var.nome_ambiente}.zip")
}
