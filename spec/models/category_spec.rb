require 'spec_helper'

describe Category, 'Associations' do
  should_have_many :proposals
end

describe Category, 'Validations' do
  should_validate_presence_of :name
  should_validate_numericality_of :expiry_seconds, :allow_nil => false
  should_validate_numericality_of :required_participation_percentage, :allow_nil => false
end