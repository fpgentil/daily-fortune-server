require 'spec_helper'

class ExampleQuery < BaseQuery; end;
class ExampleTest; include Mongoid::Document; field :name; end;

describe ExampleQuery do
  describe "#initialize" do
    let(:query) { described_class.new "teste"}

    it { expect(query.relation).to eq "teste"}
  end

  describe "paginate" do
    let(:query) { described_class.new(ExampleTest.all).paginate }
    it { expect(query.metadata).to_not be_nil}
  end

end
