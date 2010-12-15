class CommentsController < InheritedResources::Base
  actions :create
  belongs_to :proposal
  
  def create
    @comment = parent.comments.new(params[:comment])
    @comment.user = current_user
    create! do |success, failure|
      success.html { redirect_to(parent) }
    end
  end
end