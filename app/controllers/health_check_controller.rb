require 'sinatra/base'
require 'sidekiq/api'

module Sinatra
  class HealthCheckController < BaseController
    before do
      @config_healthcheck = {
        queue_latency_param: Config.sidekiq_queue_latency_param,
        queue_backlog_param: Config.sidekiq_queue_backlog_param
      }
    end
    get '/' do
      body   HealthCheck::ExternalConnection.failure? ? "WARN" : "LIVE"
      status 200
    end

    get '/status' do
      body HealthCheck::ExternalConnection.all.to_json
    end

    get '/queue-latency/:queue_name' do
      status = "WARN"
      if (Sidekiq::Queue.new(params[:queue_name]).latency < @config_healthcheck[:queue_latency_param])
        status = "LIVE"
      end
      body status
      status 200
    end

    get '/queue-backlog/:queue_name' do
      status = "WARN"
      if (Sidekiq::Queue.new(params[:queue_name]).size < @config_healthcheck[:queue_backlog_param])
        status =  "LIVE"
      end
      body status
      status 200
    end

    get '/queue-status/:queue_name' do
      status = {backlog: Sidekiq::Queue.new(params[:queue_name]).size, latency: Sidekiq::Queue.new(params[:queue_name]).latency }
      body status.to_json
      status 200
    end

  end
end
