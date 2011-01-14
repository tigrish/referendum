class ProposalsController < InheritedResources::Base
  actions :all, :except => [:edit, :update, :destroy]
  
  has_scope :state, :accepted, :rejected
  
  def create
    @proposal = Proposal.new(params[:proposal])
    @proposal.user = current_user
    create!
  end
end
