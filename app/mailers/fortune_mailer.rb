class FortuneMailer < ActionMailer::Base
  default from: "cdigentil@gmail.com"

  def notification(target_email, fortune)
    @fortune = fortune
    mail(to: target_email, subject: "Your today's fortune") do |format|
      format.text
      format.html
    end.deliver
  end
end