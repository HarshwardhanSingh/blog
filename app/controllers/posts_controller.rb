class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy,:like,:unlike]

  def index
    @posts = Post.all
  end

  def show
    
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      respond_to do |format|
        format.html{redirect_to posts_path}
        format.js{}
      end
    else
      redirect_to :back,flash[:notice]="Post could not be created."
    end
    redirect_to posts_path
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    if @post.user_id = current_user.id
      @post.destroy
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    else
      redirect_to :back,flash[:notice]="Unauthorized action"
    end
  end

  def like
    if !current_user.likes?(@post)
      current_user.like!(@post)
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    else
      redirect_to :back,flash[:notice]="You already liked this post"
    end
  end

  def unlike
    if current_user.likes?(@post)
      current_user.unlike!(@post)
      respond_to do |format|
        format.html{redirect_to :back}
        format.js{}
      end
    else
      redirect_to :back,flash[:notice]="You haven't liked this post"
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content)
    end
end
