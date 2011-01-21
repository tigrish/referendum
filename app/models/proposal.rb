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
      transitions :from => :open, :to => :closed, :on_transition => :do_close
    end
  end
  
  default_scope order('id DESC')
  scope :state, lambda { |state| where('state = ?', state) }
  scope :accepted, where(:accepted => true)
  scope :rejected, where(:accepted => false)
  
  def rejected?
    !accepted?
  end
  
protected

  def do_close
    self.accepted  = votes.count > 0 && votes.in_favor.count > votes.count/2
    self.closed_at = Time.now
  end
end
