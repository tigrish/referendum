require 'spec_helper'

describe User, 'associations' do
  should_have_many :votes
end

describe User, "validations" do
  should_validate_presence_of :name
end