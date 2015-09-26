ENV["RACK_ENV"] ||= "development"
SINATRA_ROOT = "#{File.dirname(__FILE__)}/.."
APP_ROOT = "#{File.dirname(__FILE__)}/../app"

$LOAD_PATH.unshift(APP_ROOT)

require 'rubygems'
require 'bundler'
require 'rack/contrib'

require 'sinatra/r18n'
R18n::I18n.default = 'pt-br'
R18n.default_places { "./i18n" }
R18n.set('pt-br')

Bundler.require(:default, ENV["RACK_ENV"].to_sym)

unless ENV["RACK_ENV"].to_sym == :production
  require 'dotenv'
  Dotenv.load
end

set :root, APP_ROOT
set :views, Proc.new { File.join(root, "views") }

# making sure to load config.rb before everything else
require "#{File.dirname(__FILE__)}/../config/config.rb"
Mongoid.load!("#{SINATRA_ROOT}/config/mongoid.yml")

Dir["#{File.dirname(__FILE__)}/../config/**/*.rb"].each { |f| require(f) unless f =~ /unicorn/}
Dir["#{File.dirname(__FILE__)}/../lib/**/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/../errors/**/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/../app/models/concerns/**/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/../app/enrichers/**/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/../app/services/concerns/*.rb"].each { |f| require(f) }
Dir["#{File.dirname(__FILE__)}/../app/**/*.rb"].each { |f| require(f) }

MultiJson.use :oj
Jbuilder.key_format camelize: :lower

use Rack::PostBodyContentTypeParser

error 500 do
  json success: false, errors: "Internal server error"
end

error 404 do
  json success: false, errors: "Not Found"
end
