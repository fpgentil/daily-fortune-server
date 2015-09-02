require 'sinatra/base'
require 'sidekiq/api'

module Sinatra
  class BaseController < Sinatra::Base
    use Rack::RequestId
  end
end
