require 'spec_helper'

describe Sinatra::HealthCheckController do

  let(:config) { YAML.load(ERB.new(File.read("#{SINATRA_ROOT}/config/application.yml")).result)[ENV["RACK_ENV"]] }

  def app
    @app ||= described_class
  end

  describe 'GET /healthcheck' do
    subject { '/' }

    context "when everything is allright" do
      before do
        get subject
      end

      it { expect(last_response.status).to eq 200 }
      it { expect(last_response.body).to eq 'LIVE' }
    end

    context "when has a alert" do
      before do
        allow(HealthCheck::ExternalConnection).to receive(:check_redis).and_return false
        get subject
      end

      it { expect(last_response.status).to eq 200 }
      it { expect(last_response.body).to eq 'WARN' }
    end
  end

  describe 'GET /healthcheck/status' do
    subject { '/status' }
    before do
      get subject
    end
    it { expect(last_response.status).to eq 200 }
    it { expect(last_response.body).to eq HealthCheck::ExternalConnection.all.to_json }
  end

  describe 'GET /queue-latency/default' do
    subject { '/queue-latency/default' }

    context 'getting status' do
      before do
        get subject
      end

      it { expect(last_response.status).to eq 200 }
    end

    context 'getting latency' do
      let(:queue_latency_param) { config[:healthcheck][:sidekiq][:queue_latency_param] }

      context 'when latency is lower than queue_latency_param' do
        it 'responds with body LIVE' do
          allow_any_instance_of(Sidekiq::Queue).to receive(:latency).and_return(queue_latency_param - 10)
          get subject
          expect(last_response.body).to eq 'LIVE'
        end
      end

      context 'when latency is higher than queue_latency_param' do
        it 'responds with body WARN' do
          allow_any_instance_of(Sidekiq::Queue).to receive(:latency).and_return(queue_latency_param + 10)
          get subject
          expect(last_response.body).to eq 'WARN'
        end
      end
    end
  end

  describe 'GET /queue-backlog/default' do
    subject { '/queue-backlog/default' }

    context 'getting status' do
      before do
        get subject
      end

      it { expect(last_response.status).to eq 200 }
    end

    context 'getting backlog' do
      let(:queue_backlog_param) { config[:healthcheck][:sidekiq][:queue_backlog_param] }

      context 'when size is lower than queue_backlog_param' do
        it 'responds with body LIVE' do
          allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(queue_backlog_param - 10)
          get subject
          expect(last_response.body).to eq 'LIVE'
        end
      end

      context 'when size is higher than queue_backlog_param' do
        it 'responds with body WARN' do
          allow_any_instance_of(Sidekiq::Queue).to receive(:size).and_return(queue_backlog_param + 10)
          get subject
          expect(last_response.body).to eq 'WARN'
        end
      end
    end
  end

  describe 'GET /queue-status/default' do
    subject { '/queue-status/default' }

    context 'getting status' do
      before do
        get subject
      end
      let(:response) { { backlog: 0, latency: 0} }

      it { expect(last_response.status).to eq 200 }
      it { expect(last_response.body).to eq response.to_json }
    end
  end

end
