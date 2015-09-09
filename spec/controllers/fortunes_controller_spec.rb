require 'spec_helper'

describe Sinatra::FortunesController do

  def app
    @app ||= described_class
  end

  describe 'GET /random' do
    subject { '/random' }

    context 'success' do
      before { get subject }

      it 'returns a string' do
        expect(last_response.body).to be_instance_of(String)
        expect(last_response.body).not_to be_empty
      end

      it 'returns 200' do
        expect(last_response.status).to eq 200
      end
    end

    context 'not success' do
      before do
        allow_any_instance_of(Fortune).to receive(:random) { '' }
        get subject
      end

      it 'returns a string' do
        expect(last_response.body).to be_instance_of(String)
        expect(last_response.body).to be_empty
      end

      it 'returns 422' do
        expect(last_response.status).to eq 422
      end
    end
  end

  describe 'GET /database' do
    subject { '/database' }

    context 'success' do
      before { get subject, { q: 'computers' } }

      it 'returns a string' do
        expect(last_response.body).to be_instance_of(String)
        expect(last_response.body).not_to be_empty
      end

      it 'returns 200' do
        expect(last_response.status).to eq 200
      end
    end

    context 'not success' do
      before do
        allow_any_instance_of(Fortune).to receive(:find_by) { '' }
        get subject
      end

      it 'returns a string' do
        expect(last_response.body).to be_instance_of(String)
        expect(last_response.body).to be_empty
      end

      it 'returns 422' do
        expect(last_response.status).to eq 422
      end
    end
  end

end