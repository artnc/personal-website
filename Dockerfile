FROM alpine:3.16.0

ENV LANG C.UTF-8

RUN apk add --no-cache \
    build-base \
    curl \
    libffi-dev \
    nodejs \
    npm \
    openssh \
    pngcrush \
    py3-pip \
    python3-dev \
    rsync \
    ruby-dev \
    sqlite \
  && gem install bundler \
  && npm install -g \
    html-minifier-terser@7.0.0-alpha.1 \
  && pip3 install --upgrade pip \
  && pip3 install wheel \
  && pip3 install \
    isso==0.13.0

WORKDIR /code

COPY . .

RUN bundle install
