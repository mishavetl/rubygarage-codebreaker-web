FROM ubuntu:16.04

WORKDIR /app

COPY . /app

RUN apt-get update && apt-get install -y ruby2.3 git nodejs npm && apt-get clean
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN cd /app && gem install bundler && bundle install && npm install -g gulp-cli && npm install
