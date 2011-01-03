class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  
  validates_inclusion_of  :value, :in => [-1, 1]
  validates_uniqueness_of :proposal_id, :scope => :user_id
end
