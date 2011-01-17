class ProposalsController < InheritedResources::Base
  actions :all, :except => [:edit, :update, :destroy]
  
  has_scope :state, :accepted, :rejected
  
  def create
    @proposal = Proposal.new(params[:proposal])
    @proposal.user = current_user
    create!
  end
  
protected

  def collection
    @proposals ||= end_of_association_chain.paginate(:page => params[:page])
  end
end
