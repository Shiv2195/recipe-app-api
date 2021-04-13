FROM python:3.7-alpine

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt ./requirements.txt
RUN apk add --update --no-cache postgresql-client
RUN apk add --update --no-cache --virtual .tmp-build-deps \
         libc-dev gcc linux-headers postgresql-dev musl-dev

RUN pip install -r /requirements.txt
RUN apk del .tmp-build-deps

RUN mkdir /app
WORKDIR /app
COPY ./app /app

RUN adduser -D user
USER user
