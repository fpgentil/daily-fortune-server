FROM ruby:2.2.3
MAINTAINER fpgentil(cdigentil@gmail.com)

# Prepare Container
RUN \
  apt-get update -qq && \
  apt-get install -y build-essential

# Fortune
RUN \
  apt-get install -y fortune-mod && \
  ln -s /usr/games/fortune /usr/local/bin/fortune

# For Nokogiri
RUN apt-get install -y libxml2-dev libxslt1-dev

# Install Nginx
RUN \
  apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/* && \
  echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  chown -R www-data:www-data /var/lib/nginx

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

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

EXPOSE 80

CMD foreman start -f Procfile