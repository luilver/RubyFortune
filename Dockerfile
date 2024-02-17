FROM ruby:3.2-alpine

RUN apk add --no-cache --update \
    build-base \
    curl \
    git \
    sqlite-dev

WORKDIR /app

COPY . .

RUN gem update --system && \
    ./bin/setup

EXPOSE 9292

CMD rackup
