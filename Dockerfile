FROM alpine:3.15.0

RUN apk add --no-cache \
    curl \
    g++ \
    make \
    musl-dev \
    openjdk11-jre-headless \
    openssh \
    pngcrush \
    python3 \
    rsync \
    ruby-dev \
  && gem install bundler

WORKDIR /code
COPY . .
RUN bundle install

ENV LANG C.UTF-8
