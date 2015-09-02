require File.expand_path("../config/boot.rb", __FILE__)

require 'sidekiq/web'
run Rack::URLMap.new({
  '/' => Sinatra::Application, 
  '/healthcheck' => Sinatra::HealthCheckController,
  '/sidekiq' => Sidekiq::Web
})
