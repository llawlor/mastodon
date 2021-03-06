FROM ruby:2.2.4

ENV RAILS_ENV=production

RUN echo 'deb http://httpredir.debian.org/debian jessie-backports main contrib non-free' >> /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev nodejs nodejs-legacy npm ffmpeg && rm -rf /var/lib/apt/lists/*
RUN mkdir /mastodon

WORKDIR /mastodon

ADD Gemfile /mastodon/Gemfile
ADD Gemfile.lock /mastodon/Gemfile.lock
RUN bundle install --deployment --without test development

ADD package.json /mastodon/package.json
RUN npm install

ADD . /mastodon

VOLUME ["/mastodon/public/system", "/mastodon/public/assets"]
