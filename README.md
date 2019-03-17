# Gestão de Secrets/Enviroment na AWS

No desenvolvimento de uma aplicação moderna a única coisa que deve mudar entre os deploys nos ambientes development, homolog e poduction são as configurações.

A gestão de configurações e um capítulo dos [12facter](https://12factor.net/pt_br/config)

![12factor](https://github.com/clodonil/docker-secret-aws/blob/master/img/img1.png)

Os programas que armazenam acesso a banco de dados ou outros configurações diretamente no seu código, está violando os 12fatores.

Apenas as configurações que mudam durante o deploy devem ser gerenciadas, portanto configurações como `router` ou qualquer outra configuração que não mudam durante o deploy, não devem estar na gestão de configuração.

A aplicação 12fatores armazena configuração em variáveis de ambiente (env). Env vars são fáceis de mudar entre deploys sem alterar qualquer código; ao contrário de arquivos de configuração, há pouca chance de serem colocados acidentalmente no repositório do código; e ao contrário dos arquivos de configuração personalizados, ou outros mecanismos de configuração, eles são por padrão agnósticos a linguagem e ao SO.

No modelo de configuração, precisamos armazenar os dados em um sistema centralizados, que permita que os dados sejam estruturados, para uma recuperação de dados em uma única chamada.
 
Esse sistema que armazena os dados também devem permitir o armazenamento de segredos (secret) e tudo controlado com controle de acesso, log e auditoria.

![dados](https://github.com/clodonil/docker-secret-aws/blob/master/img/img2.png)

Na AWS temos 2 serviços que atendem esses critérios e são exclusivamente para armazenamento de dados de configurações. 

São elas:

AWS Parameter Store
 * [AWS – Documentação]()
 * [AWS - Guia]()
 * [AWS - The Right Way to Store Secrets using Parameter Store]()

AWS Secrets Manager
 * [AWS – Documentação]()
 * [AWS - Guia]()

É importante reforçar que estamos falando dos serviços AWS, não estou falando de serviços montandos em cima de EC2 (Vault na AWS)

## Parameter Store

Gerencie o acesso com políticas detalhadas;
Gerenciamento escalável de dados de configuração;
Gerenciamento escalável de segredos;
Armazena dados em hierarquias e versões de trilha;
Controla e audita o acesso em níveis específicos.
Log, Auditoria e Monitoramento;
Integração com Codebuild, Codedeoploy...

Definição de preço
sem custo adicional;



## Secret Manager

Gerencie o acesso com políticas detalhadas;
chaves de criptografia;
Log, Auditoria e Monitoramento;
Integração com RDB;
Politica de rotação e expiração  de segredos;
Rotação de senhas automaticamente;
Conformidade  com o HIPAA, PCI e ISO;

Definição de preço

0,40 USD por segredo por mês;
0,05 USD por 10.000 chamadas de API.




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

![app-local](https://github.com/clodonil/docker-secret-aws/blob/master/img/img3.png)

Se tudo funcionou perfeitamente até aqui, podemos passar a AWS e colocar a nossa aplicação na AWS.

### Criando os parâmetros no SSM na AWS.

Vamos começar na AWS preenchendo os dados no Parameter Store.

Pode ser preenchido via painel da AWS..

![ssm](https://github.com/clodonil/docker-secret-aws/blob/master/img/img7.png)

Também pode ser preenchido pelo `aws-cli`.

```
$ aws ssm put-parameter --name /app/homolog/MSG --value "Olá Mundo em Homolog" --type String --key-id "alias/aws/ssm" --region us-east-1
```

### Criando o registry ECR

Vamos também criar um repositório no ECR para armazenar as imagens docker. Da mesma forma o repositório pode ser criado via painel ou pelo `aws-cli`.



### Cluster ECS

Vamos também precisar de um Cluster 


### Pipeline

![pipeline-source](https://github.com/clodonil/docker-secret-aws/blob/master/img/img9.png)


