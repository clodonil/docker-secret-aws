
FROM ubuntu:latest
LABEL maintainer Clodonil Trigo "clodonil@nisled.org"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential wget
RUN wget https://github.com/Droplr/aws-env/raw/master/bin/aws-env-linux-amd64 -O /bin/aws-env && \
    chmod +x /bin/aws-env

ENV PORT='8080'
ENV DEBUG='True'
ENV ENVIRONMENT='Development'
ENV MSG="Hello Word!!!"
                  

COPY . /app
WORKDIR /app
RUN pip install -r requirements
#ENTRYPOINT ["python"]
#CMD ["run.py"]
CMD ["/bin/bash", "-c", "eval $(aws-env) && python run.py"]