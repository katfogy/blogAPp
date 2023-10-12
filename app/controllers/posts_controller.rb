class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.comments_counter = 0
    @post.likes_counter = 0

    if @post.save
      redirect_to user_post_path(current_user, @post)
    else
      render 'new'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    Comment.where(post_id: @post.id).destroy_all
    Like.where(post_id: @post.id).destroy_all
    @post.destroy
    flash[:success] = 'Post Has been deleted'
    redirect_to user_path(@post.author), notice: 'Deleted!'
  end

  private

  def post_params
    params.require(:add_post).permit(:title, :text)
  end
end
