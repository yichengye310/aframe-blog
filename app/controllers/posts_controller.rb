class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]
  before_action :check_user, only: [:new, :edit, :update, :destroy]

  def index
    @posts = Post.all.order("created_at DESC")
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

    if @post.save
      @page = MetaInspector.new(@post.url)
      doc = Nokogiri::HTML(@page.to_s)

      @post.title = @page.title
      @post.excerpt = @page.description
      @post.image = @page.images.best
      @post.category = @page.meta_tag['property']['article:section']
      
      if @page.meta_tag['property']['article:publisher'].include? "medium"
        @post.body = doc.css('.section-content') 
      else
        @post.body = doc.css('.entry-content').first
      end
    end


    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :image, :url, :excerpt)
    end

    def check_user
      if current_user.id == 1
        nil
      else
        redirect_to root_path
      end
    end
end
