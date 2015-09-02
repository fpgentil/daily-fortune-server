#
# Configuration for Hermes Unicorn server.
#
# Insted of changing the values here, consider using /etc/sysconfig/hermes to
# set environment specific configurations.
#
# For local development environments put the appropriate values in your
# ~/.bash_profile or ~/.bashrc
#
app_dir = "/app"

working_directory ENV['HERMES_COCKPIT_DIR']             || app_dir
stderr_path       ENV['HERMES_COCKPIT_UNICORN_LOG']     || "#{app_dir}/log/unicorn.log"
stdout_path       ENV['HERMES_COCKPIT_UNICORN_LOG']     || "#{app_dir}/log/unicorn.log"
listen            ENV['HERMES_COCKPIT_UNICORN_SOCK']    || "/tmp/unicorn.sock"
pid               ENV['HERMES_COCKPIT_UNICORN_PID']     || "#{app_dir}/tmp/unicorn.pid"
worker_processes  ENV['HERMES_COCKPIT_UNICORN_WORKERS'] ? ENV['HERMES_COCKPIT_UNICORN_WORKERS'].to_i : 2
timeout           ENV['HERMES_COCKPIT_UNICORN_TIMEOUT'] ? ENV['HERMES_COCKPIT_UNICORN_TIMEOUT'].to_i : 30
preload_app       ENV['HERMES_COCKPIT_UNICORN_PRELOAD'] == "true"
