class MailWorker
  include Sidekiq::Worker

  def perform user_id
    user = User.find user_id
    return unless user.active?

    fortune = if user.databases.empty?
                Fortune.random
              else
                database = user.databases.sample
                Fortune.find_by(database: database)
              end

    FortuneMailer.notification(user.email, fortune)
    self.class.perform_in(24.hours, user_id)
  end
end