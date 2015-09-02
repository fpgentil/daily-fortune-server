require "simplecov"
require 'simplecov-rcov'
require 'simplecov-json'
require 'vcr'
# require 'mock_aws_s3_on_memory'
# require 'sidekiq/testing'
class SimpleCov::Formatter::MergedFormatter
  def format(result)
     SimpleCov::Formatter::HTMLFormatter.new.format(result)
     SimpleCov::Formatter::RcovFormatter.new.format(result)
     SimpleCov::Formatter::JSONFormatter.new.format(result)
  end
end
SimpleCov.formatter = SimpleCov::Formatter::MergedFormatter

SimpleCov.start do
  add_filter "spec/"
  add_filter "config"
  add_filter "vendor"
end

ENV['RACK_ENV'] = 'test'

require File.expand_path(File.dirname(__FILE__) + "/../config/boot")
Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each { |f| require(f) }
Dotenv.load('.env.test')

module RSpecMixin
  include Rack::Test::Methods
  def app() Sinatra::Application end
end

require 'sinatra/r18n'
R18n::I18n.default = 'pt-br'
R18n.default_places { '#{APP_ROOT}/../i18n'}
R18n.set('pt-br')

RSpec.configure do |config|
  config.include RSpecMixin

  # Factory Girl config
  config.include FactoryGirl::Syntax::Methods
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

  # Mock AWS S3 On Memory
  # config.before(:each) { MockAwsS3OnMemory.clear }
end

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = "spec/fixtures/vcr"
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.ignore_hosts 'codeclimate.com'
end

RSpec::Sidekiq.configure do |config|
  Sidekiq::Worker.clear_all

  # Clears all job queues before each example
  config.clear_all_enqueued_jobs = true # default => true

  # Whether to use terminal colours when outputting messages
  config.enable_terminal_colours = true # default => true

  # Warn when jobs are not enqueued to Redis but to a job array
  config.warn_when_jobs_not_processed_by_sidekiq = true # default => true
end
system 'redis-cli flushall'
