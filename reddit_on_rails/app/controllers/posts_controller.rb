class PostsController < ApplicationController
  before_action :require_login

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.sub_id = params[:sub_id]
    @post.user_id = current_user.id

    if @post.save
      redirect_to sub_post_url(@post.sub_id, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])

    if post_author?
      render :edit
    else
      flash.now[:errors] = ["Cannot edit another user's post"]
      redirect_to sub_post_url(@post.sub_id, @post)
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      redirect_to sub_post_url(@post.sub_id, @post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content)
  end

  def post_author?
    current_user.id == Post.find(params[:id].user_id)
  end
end
