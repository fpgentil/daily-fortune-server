require 'spec_helper'

describe HealthCheck::ExternalConnection do
  before :each do
  end
  describe ".check_redis" do
    context "when redis is unavailable" do
      let(:redis_conn) { allow(double).to receive(:ping).and_raise(Redis::CannotConnectError) }
      before :each do
        allow(Sidekiq).to receive(:redis).and_yield(redis_conn)
      end

      it { expect(described_class.check_redis).to eq false}
    end

    context "when redis is available" do
      it { expect(described_class.check_redis).to eq true}
    end
  end

  describe ".all" do
    context "when everything is alright" do

      let(:expected_hash) do
        { redis: true }
      end
      it do
        expect(described_class.all).to eq expected_hash
      end
    end

    context "when redis is unavailable" do 
      let(:expected_hash) do
        { redis: false }
      end
      before :each do
        allow(described_class).to receive(:check_redis).and_return(false)
      end

      it do
        expect(described_class.all).to eq expected_hash
      end
    end
  end

  describe ".failure?" do
    context "when everything is allright" do
      it { expect(described_class).to_not be_failure}
    end

    context "when has a failure" do
      before :each do
        allow(described_class).to receive(:check_redis).and_return(false)
      end

      it { expect(described_class).to be_failure}
    end
  end

  describe ".ok?" do
    context "when everything is allright" do
      it { expect(described_class).to be_ok}
    end

    context "when has a failure" do
      before :each do
        allow(described_class).to receive(:check_redis).and_return(false)
      end

      it { expect(described_class).to_not be_ok}
    end
  end
end
