class PostsController < ApplicationController
  allow_unauthenticated_access only: [:show]
  before_action :set_blog

  def show
    @post = Post.find(params[:id])
    @blog = Blog.find(@post.blog_id)
    @comments = Comment.where(post_id: params[:id])
    @comment = Comment.new
    @current_user = Current.user
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.blog_id = @blog.id

    if @post.save
      redirect_to @post
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_blog
    if authenticated? then end

    @blog = Blog.find_by(user_id: Current.user)
  end

  def post_params
    params.expect(post: [:title, :content])
  end
end
