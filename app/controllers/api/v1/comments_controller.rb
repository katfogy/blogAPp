class Api::V1::CommentsController < ActionController::API
  def index
    comments = Comment.where(author_id: params[:user_id])
    render json: comments, status: :ok
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.author = @user

    if @comment.save
      render json: @comment, status: :created
    else
      render json: { error: @comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
