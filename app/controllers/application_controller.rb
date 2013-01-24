class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def user_posts
    session[:user_posts]
  end

  def can_edit?
    !user_posts.nil? && user_posts.member?(@post.id)
  end

  def assign_post
    @post_id = params[:id]
    @post = Post.find(@post_id)
    @editable = can_edit? || admin_signed_in?
  end
end
