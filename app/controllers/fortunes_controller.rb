require 'sinatra/base'

module Sinatra
  class FortunesController < BaseController

    get '/random' do
      fortune = Fortune.new.random
      status_code = fortune.present? ? 200 : 422

      body fortune
      status status_code
    end

  end
end
