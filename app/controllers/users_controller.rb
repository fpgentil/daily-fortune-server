require 'sinatra/base'
require 'sinatra/respond_with'
require 'sinatra/json'

module Sinatra
  class UsersController < BaseController
    register Sinatra::RespondWith

    post '/subscribe' do
      user = User.create(params[:user])
      status user.persisted? ? 201 : 422
      # TODO move to a JBuilderTemplate
      body user.errors.full_messages || user.inspect
    end

    post '/unsubscribe' do
    end

    get '/:user_email' do
    end

  end
end
