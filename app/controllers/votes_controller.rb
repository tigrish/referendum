class VotesController < InheritedResources::Base
  actions :create
  belongs_to :proposal
  
  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user
    @vote.proposal = parent
    create! { parent_path }
  end
end
