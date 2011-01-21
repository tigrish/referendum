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
  
  it "sets accepted to true when over 50% of the votes are in_favor" do
    3.times { Factory(:vote, :proposal => @proposal, :value => 1)  }
    1.times { Factory(:vote, :proposal => @proposal, :value => -1) }
    @proposal.close!
    @proposal.should be_accepted
  end
    
  it "sets accepted to false when under 50% of the votes are in favor" do
    1.times { Factory(:vote, :proposal => @proposal, :value => 1)  }
    3.times { Factory(:vote, :proposal => @proposal, :value => -1) }
    @proposal.close!
    @proposal.should be_rejected
  end
  
  it "sets accepted to false when there are no votes" do
    @proposal.close!
    @proposal.should be_rejected
  end
  
  it "sets accepted to false when there is only 1 vote and it is against" do
    Factory(:vote, :proposal => @proposal, :value => -1)
    @proposal.close!
    @proposal.should be_rejected
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