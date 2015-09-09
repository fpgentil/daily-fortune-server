require 'spec_helper'

describe Fortune do
  subject { described_class.new }

  it { should be_instance_of(described_class) }

  describe '#fortune' do
    it 'results a string' do
      expect(subject.random).to be_instance_of(String)
    end
  end

  describe '#find_by' do
    context 'using a database' do
      let(:options) { { database: 'computers' } }

      it 'results a string' do
        expect(subject.find_by(options)).to be_instance_of(String)
      end
    end

    context 'using a pattern' do
      skip
    end
  end
end