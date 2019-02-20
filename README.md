# Variável de Ambiente e Secrets na AWS

Aplicativo em Python (Flask) para validação de variável de ambiente e secret's em containner para AWS.

Build da imagem:

```bash
$ docker build -t docker-secret-aws:latest .
```

Executando app:

```bash
$ docker run -d -p 8080:8080 docker-secret-aws:latest
```

Validando variável de ambiente:

```bash
$ docker run -d -p 8080:8080 -e ENVIRONMENT='Development' -e MSG="Ola Mundo!!!" docker-secret-aws:latest
```

Criando os parâmetros no SSM.

Environment Homolog:

```
$ aws ssm put-parameter --name /homolog/MSG --value "Olá Mundo em Homolog" --type String --key-id "alias/aws/ssm" --region us-west-1
```
Environment Production:
```
$ aws ssm put-parameter --name /prod/MSG --value "Olá Mundo em Production" --type String --key-id "alias/aws/ssm" --region us-west-1```




```
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "AllowPushPull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::aws_account_id:user/push-pull-user-1",
          "arn:aws:iam::aws_account_id:user/push-pull-user-2"
        ]
      },
      "Action": [
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "ecr:BatchCheckLayerAvailability",
        "ecr:PutImage",
        "ecr:InitiateLayerUpload",
        "ecr:UploadLayerPart",
        "ecr:CompleteLayerUpload"
      ]
    }
  ]
}
```

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/pipeline-p1.png)

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/pipeline-step2.png)

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/pipeline-deploy.png)

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/ecr-repo.png)

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/ecs-create-cluster.png)

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/cluster-service.png)






