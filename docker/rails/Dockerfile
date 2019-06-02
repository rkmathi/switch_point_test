FROM ruby:2.6.3

ENV LANG C.UTF-8

WORKDIR /app

ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-${DOCKERIZE_VERSION}.tar.gz \
  && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
  && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES 1

COPY \
  Gemfile \
  Gemfile.lock \
  /app/

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    graphviz \
    imagemagick \
    libmagickwand-dev \
    libxml2 \
    libxml2-dev \
    libxslt1-dev \
    mysql-client \
  && rm -rf /var/lib/apt/lists/* \
  && bundle config path /usr/local/bundle \
  && bundle install --jobs=2

EXPOSE 3333
COPY . /app
