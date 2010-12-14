require 'spec_helper'

describe User do
  should_validate_presence_of(:email)
end
