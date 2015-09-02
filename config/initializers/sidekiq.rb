redis_config = {
  url:        Config.redis_url,
  namespace:  Config.redis_namespace,
  password:   Config.redis_password
}
Sidekiq.configure_server { |config| config.redis = redis_config }
Sidekiq.configure_client { |config| config.redis = redis_config }
