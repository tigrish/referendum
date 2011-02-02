class Category < ActiveRecord::Base
  has_many :proposals

  validates_presence_of :name
  validates_numericality_of :expiry_seconds, :allow_nil => false
  validates_numericality_of :participation_percentage, :allow_nil => false
end