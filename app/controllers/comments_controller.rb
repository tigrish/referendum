class CommentsController < InheritedResources::Base
  before_filter :authenticate_user!
  actions :create
  nested_belongs_to :category, :proposal
  
  def create
    @comment = parent.comments.new(params[:comment])
    @comment.user = current_user
    create! { parent_url }
  end
end