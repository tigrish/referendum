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
