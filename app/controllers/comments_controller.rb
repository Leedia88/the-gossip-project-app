class CommentsController < ApplicationController
  before_action :set_comment, only: %i[ show edit update destroy ]

  # GET /comments or /comments.json
  def index
  end

  # GET /comments/1 or /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    @gossip = Gossip.find(params[:gossip_id])
    @user = User.find(@gossip.user_id)
    @users = User.full_name_list  
    @tags = TagGossip.find_tags_id(params[:gossip_id].to_i)
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments or /comments.json
  def create
    @gossip = Gossip.find(params[:gossip_id])
    @user = User.find(@gossip.user_id)
    @users = User.full_name_list  
    @tags = TagGossip.find_tags_id(params[:gossip_id].to_i)
    @comment = Comment.new(comment_params.merge(gossip_id: params[:gossip_id]))
    respond_to do |format|
      if @comment.save
        redirect_to comment_url(@comment), notice: "Comment was successfully created."
        
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to comment_url(@comment), notice: "Comment was successfully updated." }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:user_id, :content)
    end


end
