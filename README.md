# Variável de Ambiente e Secrets na AWS

Aplicativo em Python (Flask) para validação de variável de ambiente e secret's em containner para AWS.

Build da imagem:

```bash
$ dockebuild -t docker-secret-aws:latest .
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