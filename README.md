# Gestão de Secrets/Enviroment na AWS

Em um processo de gestão de ambientes
Variável de Ambiente e Secrets na AWS

![12factor](https://github.com/clodonil/docker-secret-aws/blob/master/img/12factor.png)


## Parameter Store


## Secret Manager


## laboratório/PoC 

Para o desenvolvimento desse laboratório, usei como base a documentação da AWS ["the right way to store secrets using parameter store"](https://aws.amazon.com/pt/blogs/mt/the-right-way-to-store-secrets-using-parameter-store/) que descreve a melhor forma de aplicar o "Parameter Store" em um container.

Vamos começar o laboratório com aplicação ('Hello Word') que basicamente busca as informações do 'Parameter Store'. O aplicativo foi desenvolvido em Python (Flask) para validação de variável de ambiente e secret's em containner para AWS.

Clone o projeto do [código fonte](https://github.com/clodonil/docker-secret-aws.git) para validar localmente.

```bash
$ git clone https://github.com/clodonil/docker-secret-aws.git
```

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
Para validar acesse o navegador para validar:

![app-local](https://github.com/clodonil/docker-secret-aws/blob/master/img/local-app.png)

Se tudo funcionou perfeitamente até aqui, podemos passar a AWS e colocar a nossa aplicação na AWS.

### Criando os parâmetros no SSM na AWS.

Vamos começar na AWS preenchendo os dados no Parameter Store.

Pode ser preenchido via painel da AWS..

![ssm](https://github.com/clodonil/docker-secret-aws/blob/master/img/ssm.png)

Também pode ser preenchido pelo `aws-cli`.

```
$ aws ssm put-parameter --name /app/homolog/MSG --value "Olá Mundo em Homolog" --type String --key-id "alias/aws/ssm" --region us-east-1
```

### Criando o registry ECR

Vamos também criar um repositório no ECR para armazenar as imagens docker. Da mesma forma o repositório pode ser criado via painel ou pelo `aws-cli`.

![repo](https://github.com/clodonil/docker-secret-aws/blob/master/img/ecr-repo.png)


### Cluster ECS

Vamos também precisar de um Cluster 

![cluster](https://github.com/clodonil/docker-secret-aws/blob/master/img/ecs-create-cluster.png)

![service](https://github.com/clodonil/docker-secret-aws/blob/master/img/cluster-service.png)

### Pipeline

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/pipeline-p1.png)

![pipeline-build](https://github.com/clodonil/docker-secret-aws/blob/master/img/pipeline-step2.png)

![pipeline-deploy](https://github.com/clodonil/docker-secret-aws/blob/master/img/pipeline-deploy.png)

