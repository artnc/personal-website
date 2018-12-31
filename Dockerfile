FROM ruby:2.6

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get -y --no-install-recommends install \
    default-jre \
    nodejs \
    rsync \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /code
COPY . /code
RUN bundle install

ENV LANG C.UTF-8
