class ProposalsController < InheritedResources::Base
  belongs_to :category
  actions :all, :except => [:edit, :update, :destroy]
  
  has_scope :state, :accepted, :rejected
  
  def show
    @proposal = parent.proposals.find(params[:id])
    @proposal.close! if @proposal.open? && @proposal.expired?
  end
  
  def create
    @proposal = parent.proposals.build(params[:proposal])
    @proposal.user = current_user
    create!
  end
  
protected

  def collection
    @proposals ||= end_of_association_chain.paginate(:page => params[:page])
  end
end
