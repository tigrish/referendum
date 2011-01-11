class VotesController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :create
  belongs_to :proposal
  
  def create
    @vote = Vote.new(params[:vote])
    @vote.user = current_user
    @vote.proposal = parent
    create!(:notice => t('controllers.votes.create.flash.notice')) do |format|
      format.html do
        unless @vote.errors.empty?
          flash[:alert] = @vote.errors.full_messages.unshift(t('controllers.votes.create.flash.alert')).join('. ')
        end
        redirect_to(parent)
      end
    end
  end
end
