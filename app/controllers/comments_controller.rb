class CommentsController < ApplicationController
  def new
    @post = Post.new
  end

  def create
    post = Post.find(params[:post_id])
    comment = current_user.comments.new(comments_params)
    comment.post = post
    if comment.save
      redirect_to user_post_url(id: params[:post_id])
    else
      render user_post_path(id: current_user.id)
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @post = Post.find(@comment.post_id)
    redirect_to user_path(current_user.id), notice: 'Deleted.'
  end

  private

  def comments_params
    params.require(:add_comment).permit(:text)
  end
end
