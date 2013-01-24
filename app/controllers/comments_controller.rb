class CommentsController < ApplicationController
  def new

  end

  def index
      
  end
  
  def create
      Comment.create!(params[:comment])
      redirect_to post_path(params[:comment][:post_id])
  end
end
