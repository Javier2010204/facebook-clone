class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /posts or /posts.json
  def index
    @posts = Post.all_post_for_user(current_user).paginate(page:params[:page], per_page:10)
    @post = current_user.posts.new
  end

  # GET /posts/1 or /posts/1.json
  def show
    @comment = @post.comments.new
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def like
    puts "Like"
    @post = Post.find(params[:id])
    Like.create(user_id: current_user.id, post_id: @post.id)
    respond_to do |format|
      format.html{redirect_to :root}
    end
  end

  def dislike
    puts "Dislike"
    @post = Post.find(params[:id])
    @like = Like.where(user_id: current_user.id, post_id: @post.id).first
    @like.destroy
    respond_to do |format|
      format.html { redirect_to :root, notice: "Like eliminado con exito" }
      format.json { head :no_content }
    end

  end
  

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # RUBY 

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:body, :user_id)
    end
end
