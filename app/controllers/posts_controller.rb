class PostsController < ApplicationController
  def index  

    session[:posts_showed] = 2
    @posts_showed = session[:posts_showed]

    @include_tags = session[:include_tags].nil? ? [] : session[:include_tags]
    @exclude_tags = session[:exclude_tags].nil? ? [] : session[:exclude_tags]
    @include_tags -= @exclude_tags if !@include_tags.nil?
    @exclude_tags -= @include_tags if !@exclude_tags.nil?

    @all_tags = Post.tag_counts_on(:tags)

    @posts = Post.all
    session[:post] = nil
  end
  
  def show
    assign_post

    @comment = Comment.new
    @comments = Comment.where(:post_id => @post.id).all
  end

  def new
    @tags = Post.tag_counts_on(:tags)
    if session[:post].nil?
      @post = Post.new
    else
      @post = Post.new(session[:post])
    end
    @post.images.build
  end
  
  def create
    #session[:post] = params[:post].except(:images)
    if !admin_signed_in? && !verify_recaptcha
      flash[:warning] = "Wrong captcha"
      redirect_to new_post_path
      return
    end
    @post = Post.new(params[:post])
    if @post.save
      flash.keep[:notice] = "Post was successfully created."
      session[:post] = nil
      if session[:user_posts].nil?
        session[:user_posts] = [@post.id]
      else
        session[:user_posts].insert(0, @post.id)
      end
      redirect_to @post
    else
      render :action => 'new'
    end
  end
  
  def edit
    assign_post
    @tags = Post.tag_counts_on(:tags)
    if !@editable
      flash[:warning] = "Not your post to edit"
      redirect_to @post
    end
    @post.images.build
  end

  def update
    assign_post
    # session[:post] = params[:post].except(:images)

    if !admin_signed_in? && !verify_recaptcha
      flash[:warning] = "Wrong captcha"
      redirect_to edit_post_path(@post)
      return
    end


    if @editable && @post.update_attributes(params[:post])
      flash[:notice] = "Successfully updated post"
      redirect_to post_url
    else
      flash[:notice] = "Something gone wrong!"
      redirect_to post_url
    end
    
  end

  def destroy
    assign_post
    if !@editable
      flash[:warning] = "Don't touch it!"
      redirect_to @post
    end
    if @post.destroy
        flash[:notice] = "Successfully deleted post"
        redirect_to posts_url
    else
      render :action => "delete"
    end
  end

  def preview
    @post_id = params[:id]
    @post = Post.find(@post_id)
    respond_to do | format |
        format.js {render :layout => false}
        format.html {render :partial => "preview", :layout => false}
    end
  end

  def image_preview
    if params[:post][:images_attributes].nil?
      render :partial => "blank"
    else
      @last_image_field_id = 0
      @images = params[:post][:images_attributes].reject {|k,v| v.has_key? "_destroy"}
        .map {|k,v|
          file = v["image"]
          if k.to_i > @last_image_field_id
            @last_image_field_id = k.to_i
          end
          {:filename => file.original_filename, :uri => "data:" + file.content_type +
              ";base64," + Base64.encode64(file.tempfile.read) }
      }
      @new_field_id = "post_images_attributes_#{@last_image_field_id+1}_image"
      @new_field_name = "post[images_attributes][#{@last_image_field_id+1}][image]"
      render :partial => "image_preview", :layout => false
    end
    
    
  end

  def search
    
    @search = params[:search]
    @include_tags = session[:include_tags]
    @exclude_tags = session[:exclude_tags]

    if !@include_tags.nil? && !@include_tags.empty?
      @posts = Post.tagged_with(@include_tags, :any => true)
    else
      @posts = Post
    end
    if !@exclude_tags.nil? && !@exclude_tags.empty?
      @posts = @posts.tagged_with(@exclude_tags, :exclude => true)
    end
    @posts = @posts.search(@search)
    
    @posts_showed = session[:posts_showed]
    
    render :partial => 'list'
  end

  def tags

    include_tag = params[:include_tag]
    exclude_tag = params[:exclude_tag]

    @include_tags = session[:include_tags].nil? ? [] : session[:include_tags]
    @exclude_tags = session[:exclude_tags].nil? ? [] : session[:exclude_tags]

    if !include_tag.nil?
      if !@include_tags.member?(include_tag)
        @include_tags.push(include_tag)
      else
        @include_tags.delete(include_tag)
      end
    end
    if !exclude_tag.nil?
      if !@exclude_tags.member?(exclude_tag)
        @exclude_tags.push(exclude_tag)
      else
        @exclude_tags.delete(exclude_tag)
      end

    end

    session[:include_tags] = @include_tags
    session[:exclude_tags] = @exclude_tags

    @all_tags = Post.tag_counts_on(:tags)

    render :partial => 'tags', :locals =>
      { :all_tags => @all_tags, :include_tags => @include_tags, :exclude_tags => @exclude_tags}
  end

  def show_more
     session[:posts_showed] = session[:posts_showed] + 2
     render :partial => "blank"
  end

end
