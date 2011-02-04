class Proposal < ActiveRecord::Base
  include ActiveRecord::Transitions
  
  belongs_to :category
  belongs_to :user
  has_many   :comments
  has_many   :votes
  
  validates_presence_of :category, :title, :description, :user
  before_create :set_expires_at
  
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
  scope :expired,  where(['expires_at < ?', Time.now])
  
  def rejected?
    !accepted?
  end
  
  def expired?
    expires_at < Time.now
  end

  def required_participation
    (User.count * (category.required_participation_percentage / 100.0)).ceil
  end

protected

  def set_expires_at
    self.expires_at = Time.now + category.expiry_seconds
  end

  def do_close
    self.accepted  = votes.count >= required_participation && votes.in_favor.count > votes.count/2
    self.closed_at = Time.now
  end
end
