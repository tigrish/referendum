require 'spec_helper'

describe Proposal do
  should_belong_to :user

  should_validate_presence_of :title
  should_validate_presence_of :description
  should_validate_presence_of :user
end
