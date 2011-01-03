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
