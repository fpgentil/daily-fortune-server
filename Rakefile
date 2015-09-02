require './config/boot.rb'

ENV['RACK_ENV'] ||= "development"

puts "Environment: #{ENV['RACK_ENV']}"

task :default => :help

desc "Run specs"
task :spec do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec) do |t|
    t.pattern = './spec/**/*_spec.rb'
  end
end

desc "Run IRB console with app environment"
task :console do
  puts "Loading development console..."
  system("RACK_ENV=#{ENV['RACK_ENV']} irb -r ./config/boot.rb")
end

desc "Run server with app environment"
task :server do
  puts "Loading development server..."
  system("RACK_ENV=#{ENV['RACK_ENV']} shotgun config.ru")
end

desc "Run sidekiq with app environment"
task :sidekiq do
  puts "Loading workers (sidekiq) ..."
  if File.exist?("./tmp/sidekiq-jobs.pid")
    puts "Sidekiq already running"
  else
    system("RACK_ENV=#{ENV['RACK_ENV']} bundle exec sidekiq -r ./config/boot.rb -r ./config/config.rb  -C ./config/sidekiq.yml")
  end
end

desc "Clear sidekiq with app environment"
task :sidekiq_clear do
  if ENV['RACK_ENV'] == "production"
    require 'sidekiq/api'
    Sidekiq::Queue.new("default").clear
    Sidekiq::RetrySet.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::Stats.new.reset
    Sidekiq.redis do |conn|
      conn.flushall
    end
  else
    puts "Do not execute clear on production"
  end
end

desc "show all resoursces os application"
task :routes do
  require './config/boot.rb'
  Sinatra::Application.routes['GET'].each do |route|
    puts route[0]
  end
end

desc "Remove all example files"
task :remove_example_files do
  require './config/boot.rb'
  puts "Execute the command:"
  puts "find -f #{SINATRA_ROOT} | grep -i example | awk -F' *:*' '{print $2}' | xargs rm -f"
end

desc "Show help menu"
task :help do
  puts "Available rake tasks:"
  puts "rake console - Run a IRB console with all enviroment loaded"
  puts "rake server  - Run development server"
  puts "rake spec    - Run specs and calculate coverage"
  puts "rake sidekiq - Run workers with sidekiq"
  puts "rake sidekiq_clear   - Clear sidekiq default queue "
  puts "rake remove_example_files - Remove all example files"
end
