FROM alpine:3.20.3

ENV LANG=C.UTF-8

RUN apk add --no-cache \
    bash \
    build-base \
    curl \
    libffi-dev \
    nodejs \
    npm \
    openssh \
    pngcrush \
    python3 \
    rsync \
    ruby-dev \
  && gem install bundler \
  && npm install -g \
    html-minifier-terser@7.0.0-alpha.1

WORKDIR /code

COPY . .

RUN bundle install
