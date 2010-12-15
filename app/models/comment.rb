class Comment < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user

  validates_presence_of :body
  validates_presence_of :proposal
  validates_presence_of :user
end
