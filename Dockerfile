
FROM ubuntu:latest
LABEL maintainer Clodonil Trigo "clodonil@nisled.org"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential wget git jq

ARG KEY
ARG SECRET
ARG REGION='us-east-1'

ENV AWS_ACCESS_KEY_ID=${KEY}
ENV AWS_SECRET_ACCESS_KEY=${SECRET}
ENV AWS_REGION=${REGION}

ENV PORT='8080'
ENV DEBUG='True'
ENV ENVIRONMENT='development'
ENV MSG="Hello Word!!!"

                  
COPY . /app
WORKDIR /app
RUN pip install -r requirements
RUN chmod +x aws-env.sh
#ENTRYPOINT ["bash"]
#CMD ["run.py"]
CMD ["/bin/bash", "-c", "eval $(./aws-env.sh) && python run.py"]

