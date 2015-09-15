require 'sinatra/base'
require 'sinatra/respond_with'
require 'sinatra/json'

module Sinatra
  class FortunesController < BaseController
    register Sinatra::RespondWith

    get '/random' do
      fortune = Fortune.new.random

      status response_code(fortune)
      respond_to do |f|
        f.txt  { fortune }
        f.json { { data: fortune }.to_json }
      end
    end

    get '/database' do
      fortune = Fortune.new.find_by(database: params[:q])

      status response_code(fortune)
      respond_to do |f|
        f.txt  { fortune }
        f.json { { data: fortune }.to_json }
      end
    end

    private
    def response_code(fortune)
      fortune.present? ? 200 : 422
    end
  end
end
