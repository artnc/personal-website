FROM alpine:3.15.0

RUN apk add --no-cache \
    curl \
    g++ \
    make \
    musl-dev \
    nodejs \
    npm \
    openssh \
    pngcrush \
    python3 \
    rsync \
    ruby-dev \
  && gem install bundler

WORKDIR /code

COPY . .
RUN bundle install \
  && npm install \
    html-minifier-terser@7.0.0-alpha.1

ENV LANG C.UTF-8
