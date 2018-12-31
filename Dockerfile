FROM ruby:2.6
WORKDIR /code
ADD . /code
RUN bundle install
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && apt-get -y --no-install-recommends install \
    default-jre \
    nodejs \
    rsync \
    && rm -rf /var/lib/apt/lists/*
ENV LANG C.UTF-8
