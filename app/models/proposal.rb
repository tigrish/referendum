class Proposal < ActiveRecord::Base
  include ActiveRecord::Transitions
  
  belongs_to :user
  has_many   :comments
  has_many   :votes
  
  validates_presence_of :title, :description, :user
  
  state_machine do
    state :open
    state :closed
    
    event :close do
      transitions :from => :open, :to => :closed
    end
  end
end
