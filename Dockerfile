FROM ruby:2.6.0
RUN apt-get update && apt-get install -y postgresql-client nodejs
RUN mkdir /users-api
WORKDIR /users-api
COPY . /users-api

RUN bundle install
