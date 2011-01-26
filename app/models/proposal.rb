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
    
    event :expire do
      transitions :from => :open, :to => :expired, :on_transition => :do_expire
    end
  end
  
  default_scope order('id DESC')
  scope :state, lambda { |state| where('state = ?', state) }
  scope :accepted, where(:accepted => true)
  scope :rejected, where(:accepted => false)
  scope :expired,  where(['expires_at < ?', Time.now])
  
  def rejected?
    !accepted?
  end
  
  def expired?
    expires_at < Time.now
  end
  
protected

  def before_create
    self.expires_at = Time.now + 7.days
  end

  def do_close
    self.accepted  = votes.count > 0 && votes.in_favor.count > votes.count/2
    self.closed_at = Time.now
  end
end
