class VotesController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :create
  nested_belongs_to :category, :proposal
  
  def create
    @vote = parent.votes.build(params[:vote])
    @vote.user = current_user
    create!(:notice => t('controllers.votes.create.flash.notice')) do |format|
      format.html do
        unless @vote.errors.empty?
          flash[:alert] = @vote.errors.full_messages.unshift(t('controllers.votes.create.flash.alert')).join('. ')
        end
        redirect_to(parent_path)
      end
    end
  end
end