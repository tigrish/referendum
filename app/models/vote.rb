class Vote < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates_presence_of :proposal
  validates_presence_of :user
  validates_inclusion_of  :value, :in => [-1, 1]
  validates_uniqueness_of :proposal_id, :scope => :user_id
  validate :proposal_state
  
  scope :against, where(:value => -1)
  scope :in_favor, where(:value => 1)

protected

  def proposal_state
    errors.add(:proposal, :not_open) if proposal && !proposal.open?
  end
end