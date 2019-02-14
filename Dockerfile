
FROM ubuntu:latest
LABEL maintainer Clodonil Trigo "clodonil@nisled.org"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential wget git jq
RUN wget 

ENV PORT='8080'
ENV DEBUG='True'
ENV ENVIRONMENT='Development'
ENV MSG="Hello Word!!!"
ENV AWS_ACCESS_KEY_ID
ENV AWS_SECRET_ACCESS_KEY
ENV AWS_REGION

                  
COPY . /app
WORKDIR /app
RUN pip install -r requirements
ENTRYPOINT ["bash"]
#CMD ["run.py"]
CMD ["/bin/bash", "-c", "eval $(aws-env.sh) && python run.py"]

