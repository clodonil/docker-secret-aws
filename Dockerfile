
FROM ubuntu:latest
LABEL maintainer Clodonil Trigo "clodonil@nisled.org"
RUN apt-get update -y
RUN apt-get install -y python-pip python-dev build-essential

ENV PORT='8080'
ENV DEBUG='True'
ENV ENVIRONMENT='Development'
ENV MSG="Hello Word!!!"
                  

COPY . /app
WORKDIR /app
RUN pip install -r requirements
ENTRYPOINT ["python"]
CMD ["run.py"]