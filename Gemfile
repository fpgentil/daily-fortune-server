source "https://rubygems.org"

ruby '2.2.3'

gem 'activesupport'
gem 'bundler'
gem 'bunny'
gem 'daemons'
gem 'hashie'
gem 'her'
gem 'mongoid', '~> 4.0.0'
gem 'newrelic_rpm'
gem 'nokogiri'
gem 'oj'
gem 'rack-request-id'
gem 'rake'
gem 'rack-contrib'
gem 'redis', '3.0.6'
gem 'sidekiq', '~> 3.2.5'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'sinatra-r18n'
gem 'tilt-jbuilder', '>= 0.4.0', require: 'sinatra/jbuilder'
gem 'unicorn', require: false
gem 'will_paginate_mongoid'

group :development do
  gem 'derailed'
  gem 'shotgun'
  gem 'stackprof'
  gem 'thor'
end

group :test, :development, :qa, :ci do
  gem 'database_cleaner'
  gem 'dotenv'
  gem 'factory_girl'
  gem 'faker'
  gem 'pry-meta'
  gem 'rack-test',        require: 'rack/test'
  gem 'rspec'
  gem 'rubycritic'
  gem 'simplecov'
  gem 'simplecov-rcov', require: false
  gem 'simplecov-json', require: false
  gem 'metric_fu',      require: false
end

group :test do
  gem 'rspec-sidekiq'
  gem 'timecop'
  gem 'vcr'
  gem 'webmock'
end
