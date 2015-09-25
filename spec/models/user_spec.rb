require 'spec_helper'

describe User do
  let(:user) { User.create(email: "cdigentil@gmail.com") }

  context 'generating token automatically' do
    it { expect(user.token).to be }
  end

  context 'creating active user' do
    it { expect(user.active).to be_truthy }
  end

  describe '.schedule_email' do
    it 'schedules email using sidekiq' do
      expect(MailWorker).to receive(:perform_async).with(an_instance_of(String))
      user
    end
  end

  describe '.active?' do
    context 'with an active user' do
      it { expect(user.active?).to be_truthy }
    end

    context 'with an inactive user' do
      before { user.update_attributes(active: false) }
      it { expect(user.active?).to be_falsey }
    end
  end
end