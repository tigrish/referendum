require 'spec_helper'

describe Proposal, 'associations' do
  should_belong_to :category
  should_belong_to :user
  should_have_many :comments
  should_have_many :votes
end

describe Proposal, 'validations' do
  should_validate_presence_of :category
  should_validate_presence_of :title
  should_validate_presence_of :description
  should_validate_presence_of :user
end

describe Proposal, "#create" do
  before(:each) do
    @now = Time.now
    @category = Factory.build(:category, :expiry_seconds => 60*60)
    @proposal = Factory.build(:proposal, :category => @category)
  end
  
  it "sets expires_at to now + the category's expiry_seconds" do
    Time.should_receive(:now).at_least(:once).and_return(@now)
    proc { @proposal.save }.should change(@proposal, :expires_at).to(@now + 1.hour)
  end
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

  it "sets accepted to true when minimum participation is met" do
    @proposal.update_attributes(:category => Factory(:category, :required_participation_percentage => 60))
    2.times { Factory(:vote, :proposal => @proposal, :value => 1) }
    @proposal.close!
    @proposal.should be_accepted
  end

  it "sets accepted to false when minimum participation isn't met" do
    @proposal.update_attributes(:category => Factory(:category, :required_participation_percentage => 60))
    2.times { Factory(:user) }
    2.times { Factory(:vote, :proposal => @proposal, :value => 1) }
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

describe Proposal, "#expired?" do
  it "returns true when expires_at is in the past" do
    Factory.build(:proposal, :expires_at => Time.now - 1.day).should be_expired
  end
  
  it "returns false when expires_at is in the future" do
    Factory.build(:proposal, :expires_at => Time.now + 1.day).should_not be_expired
  end
end

describe Proposal, "#rejected?" do
  it "returns true when accepted? is false" do
    Factory.build(:proposal, :accepted => false).should be_rejected
  end
  
  it "returns false when accepted? is true" do
    Factory.build(:proposal, :accepted => true).should_not be_rejected
  end
end

describe Proposal, "#required_participation" do
  it "returns the percentage of the total number of user as defined by the category's required_participation_percentage" do
    User.should_receive(:count).and_return(10)
    category = Factory(:category, :required_participation_percentage => 33)
    proposal = Factory(:proposal, :category => category)
    proposal.required_participation.should == 4
  end
end