require 'spec_helper'

describe Sinatra::UsersController do
  def app
    @app ||= described_class
  end

  describe 'POST /subscribe' do
    subject { 'subscribe' }
    let(:subscription) { post(subject, params) }

    context 'with valid params' do
      let(:params) { { user: { email: "cdigentil@gmail.com" } } }

      it 'creates an user' do
        expect{ subscription }.to change{ User.count }.from(0).to(1)
        expect(last_response.status).to eq 201
      end
    end

    context 'with invalid params' do
      let(:params) { { user: { email: nil } } }

      it 'does not create a user' do
        expect{ subscription }.not_to change{ User.count }
        expect(last_response.status).to eq 422
      end
    end
  end

  describe 'POST /unsubscribe' do
  end

  describe 'GET /:user_email' do
  end

end