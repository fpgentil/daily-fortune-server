require 'spec_helper'

describe User do
  let(:user) { User.create(email: "cdigentil@gmail.com") }

  context 'generating token automatically' do
    it { expect(user.token).to be }
  end

  context 'creating active user' do
    it { expect(user.active).to be_truthy }
  end
end