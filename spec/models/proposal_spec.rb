require 'spec_helper'

describe Proposal, 'associations' do
  should_belong_to :user
  should_have_many :comments
  should_have_many :votes
end

describe Proposal, 'validations' do
  should_validate_presence_of :title
  should_validate_presence_of :description
  should_validate_presence_of :user
end

describe Proposal, "#close!" do
  before(:each) do
    @proposal = Factory(:proposal)
    @now = Time.now
  end

  it "sets the closed_at timestamp" do
    Time.should_receive(:now).at_least(:once).and_return(@now)
    proc { @proposal.close! }.should change(@proposal, :closed_at).to(@now)
  end
end

# attribute methods

describe Proposal, "rejected?" do
  it "returns true when accepted? is false" do
    Factory.build(:proposal, :accepted => false).should be_rejected
  end
  
  it "returns false when accepted? is true" do
    Factory.build(:proposal, :accepted => true).should_not be_rejected
  end
end