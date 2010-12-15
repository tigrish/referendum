require 'spec_helper'

describe Comment do
  should_belong_to :proposal
  should_belong_to :user
  
  should_validate_presence_of :proposal
  should_validate_presence_of :user
end
