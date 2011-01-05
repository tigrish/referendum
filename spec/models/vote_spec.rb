require 'spec_helper'

describe Vote, 'associations' do
  should_belong_to :proposal
  should_belong_to :user
end

describe Vote, "validations" do
  before(:all) { Factory(:vote) }
  should_validate_inclusion_of  :value, :in => [-1, 1]
  should_validate_uniqueness_of :proposal_id, :scope => :user_id
end

describe Vote, "scopes" do
  before(:each) do
    @in_favor = Factory(:vote, :value => 1)
    @against = Factory(:vote, :value => -1)
  end
  
  describe ".in_favor" do
    it "returns votes where value is 1" do
      Vote.in_favor.should == @in_favor
    end
  end
  
  describe ".against" do
    it "returns votes where value is -1" do
      Vote.against.should == @against
    end
  end
end