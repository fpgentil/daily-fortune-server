require 'sinatra/base'
require 'sidekiq/api'

module Sinatra
  class BaseController < Sinatra::Base
    use Rack::RequestId
    use Rack::PostBodyContentTypeParser
  end
end
