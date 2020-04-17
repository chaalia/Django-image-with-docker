# pull official base image
FROM python:3.8.0-alpine

# set work directory
WORKDIR /usr/src/app/mon_lab/src

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apk update \
    && apk add postgresql-dev gcc python3-dev musl-dev

RUN apk --update add \
    build-base \
    jpeg-dev \
    zlib-dev \
    sudo \
    bash

RUN chmod g+rx,o+rx /
#RUN adduser -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# install dependencies
RUN pip install --upgrade pip
COPY ./app/requirements.txt /usr/src/app/requirements.txt
RUN pip install -r ../../requirements.txt

# copy entrypoint.sh
COPY ./app/entrypoint.sh /usr/src/app/entrypoint.sh

# copy project
COPY . /usr/src/app/

# run entrypoint.sh
ENTRYPOINT ["/usr/src/app/entrypoint.sh"]
