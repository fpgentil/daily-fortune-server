require "./config/config_helpers"

# Access all config keys like the following:
#
#     Config.database_url
#
# Each accessor corresponds directly to an ENV key, which has the same name
# except upcased, i.e. `DATABASE_URL`.
module Config
  extend Skeleton::CastingConfigHelpers

  # Mandatory -- exception is raised for these variables when missing.
  mandatory :mongo_db_name,     string
  mandatory :mongo_hosts,       array
  mandatory :redis_url,         string
  mandatory :redis_namespace,   string
  mandatory :sidekiq_namespace, string
  mandatory :mailgun_domain,    string
  mandatory :mailgun_login,     string
  mandatory :mailgun_password,  string

  # Optional -- value is returned or `nil` if it wasn't present.
  optional :new_relice_license_key, string
  optional :new_relice_app_name,    string
  optional :redis_password,         string

  # Override -- value is returned or the set default.
  override :sidekiq_queue_latency_param,  7200, int
  override :sidekiq_queue_backlog_param,  1000, int
  override :sidekiq_logfile, "log/sidekiq.log", string
  override :sidekiq_verbose, true, bool
  override :sidekiq_daemon, false, bool
end
