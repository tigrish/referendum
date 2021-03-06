require 'spec_helper'

describe Vote, 'associations' do
  should_belong_to :proposal
  should_belong_to :user
end

describe Vote, "validations" do
  should_validate_presence_of :proposal
  should_validate_presence_of :user
  should_validate_inclusion_of :value, :in => [-1, 1]
end

describe Vote, "after_save" do
  before(:each) do
    @proposal = Factory(:proposal)
    @user_1, @user_2 = Factory(:user), Factory(:user)
  end
  
  it "closes the proposal when *all* users have voted" do
    proc do
      User.all.each { |user| @proposal.votes.create(:user => user, :value => 1) }
      @proposal.reload
    end.should change(@proposal, :state).to('closed')
  end
  
  it "leaves the proposal open when NOT *all* users have voted" do
    proc do
      @proposal.votes.create(:user => @user_1, :value => 1)
    end.should_not change(@proposal, :state)
  end
end

describe Vote, "uniqueness validations" do
  before(:each) { Factory(:vote) }
  should_validate_uniqueness_of :proposal_id, :scope => :user_id
end

describe Vote, "proposal validations" do
  
  before(:all) do
    @user, @proposal = Factory(:user), Factory(:proposal)
  end
  
  it "creates a vote for an open proposal" do
    proc { @proposal.votes.create(:user => @user, :value => 1) }.should change(Vote, :count).by(1)
  end
  
  it "doesn't create a vote for a closed proposal" do
    @proposal.close!
    proc { @proposal.votes.create(:user => @user, :value => 1) }.should_not change(Vote, :count)
  end

  it "doesn't create a vote for an expired proposal" do
    @proposal.update_attribute(:expires_at, Time.now - 1.day)
    proc { @proposal.votes.create(:user => @user, :value => 1) }.should_not change(Vote, :count)
  end
end

describe Vote, "scopes" do
  before(:each) do
    @in_favor = Factory(:vote, :value => 1)
    @against = Factory(:vote, :value => -1)
  end
  
  describe ".in_favor" do
    it "returns votes where value is 1" do
      Vote.in_favor.first.should == @in_favor
    end
  end
  
  describe ".against" do
    it "returns votes where value is -1" do
      Vote.against.first.should == @against
    end
  end
end