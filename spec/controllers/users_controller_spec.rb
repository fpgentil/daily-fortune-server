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
    let!(:user) { User.create(email: 'cdigentil@gmail.com') }

    subject { 'unsubscribe' }
    let(:unsubscribe) { post(subject, token) }

    context 'with a valid token' do
      let(:token) { { token: user.token } }

      it 'unsubscribe user' do
        unsubscribe
        expect(user.reload.active).to be_falsey
        expect(last_response.status).to eq 200
      end
    end

    context 'with an invalid token' do
      let(:token) { { token: '123123123' } }

      it 'does not do anything' do
        unsubscribe
        expect(last_response.body).to be_empty
        expect(last_response.status).to eq 422
      end
    end
  end

  describe 'GET /:user_email' do
  end

end