FROM python:3
LABEL maintainer Clodonil Trigo "clodonil@nisled.org"
RUN apt-get update -y
RUN apt-get install -y jq

ARG KEY
ARG SECRET
ARG REGION='us-east-1'

ENV AWS_ACCESS_KEY_ID=${KEY}
ENV AWS_SECRET_ACCESS_KEY=${SECRET}
ENV AWS_REGION=${REGION}

ENV PORT='80'
ENV DEBUG='True'
ENV ENVIRONMENT='development'
ENV MSG="Hello Word!!!"
ENV db_url='0.0.0.0'
ENV db_user='user'
ENV db_passwd='senha'

                  
COPY . /app
WORKDIR /app
RUN pip install -r requirements
#RUN chmod +x aws-env.sh
CMD ["/bin/bash", "-c", "eval $(./aws-env.sh) && python run.py"]
#CMD ["/bin/bash"]
