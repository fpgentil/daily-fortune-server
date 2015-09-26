require "action_mailer"
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :authentication => :plain,
  :address => "smtp.mailgun.org",
  :port => 587,
  :domain => Config.mailgun_domain,
  :user_name => Config.mailgun_login,
  :password => Config.mailgun_password
}
ActionMailer::Base.view_paths = File.expand_path('../../../app/views/', __FILE__)