FROM ruby:2.2.3
MAINTAINER fpgentil(cdigentil@gmail.com)

RUN apt-get update -qq && apt-get install -y build-essential

# for nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# Install App
WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
ADD . /app

# Add default unicorn config
ADD config/unicorn.rb /app/config/unicorn.rb

RUN mkdir /app/tmp
RUN mkdir /app/log

RUN gem install foreman

# Install gems
RUN bundle install --without development test

CMD foreman start -f Procfile