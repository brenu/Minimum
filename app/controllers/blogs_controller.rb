class BlogsController < ApplicationController
  allow_unauthenticated_access only: [:index, :show]

  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.where(id: params[:id]).first
    @posts = Post.where(blog_id: @blog.id)

    if @blog.nil?
      render file: Rails.root.join('public/404.html'), status: :not_found, layout: false and return
    end
  end
end
