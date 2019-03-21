FROM python:3.7-alpine

MAINTAINER Applied AI Course Ltd

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /requirements.txt
#  uses the package manager (apk) that comes with Alpine, 
# --update = update the registry begore we add it.
# --no-cache Don't store the registry index on our docker file
RUN apk add --update --no-cache postgresql-client
# --virtual sets up an alias for our dependencies that we can 
#   use to eaily remove all those dependencies later.
RUN apk add --update --no-cache --virtual .temp-build-deps \
      gcc libc-dev linux-headers postgresql-dev  
RUN pip install -r /requirements.txt
RUN apk del .temp-build-deps 

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
