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
    context 'when something is not right' do
      skip
    end

    context 'when fortune is brought' do
      skip
    end
  end
end