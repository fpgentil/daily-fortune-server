require 'spec_helper'

describe FortuneMailer do
  describe '.notification' do
    let(:user)    { User.new(email: 'cdigentil@gmail.com') }
    let(:fortune) { 'Fortune 1' }
    let(:subject) { "Your today's fortune" }

    let(:doubled_mail) { double(:mail, delivery: true)}

    subject { described_class.notification(user.email, fortune) }

    it 'simply forward fortune to users email' do
      # expect_any_instance_of(described_class).to receive(:mail).with(
      #   to: user.email, subject: subject) { doubled_mail }
      subject
    end
  end
end
