web: bundle exec unicorn -c config/unicorn.rb
nginx: /usr/sbin/nginx -c /etc/nginx/nginx.conf
sidekiq: bundle exec sidekiq --verbose -r ./config/boot.rb -C ./config/sidekiq.yml