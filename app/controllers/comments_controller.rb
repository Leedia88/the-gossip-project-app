class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy ]


  def new
    @comment = Comment.new
    @gossip = Gossip.find(params[:gossip_id])
    @user = User.find(@gossip.user_id)
    @users = User.full_name_list  
    @tags = TagGossip.find_tags_id(params[:gossip_id].to_i)
  end

  def edit
    puts params.inspect
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @usergossip = User.find(@gossip.user_id)  
    @usercomment = User.find(@comment.user_id)
    @users = User.full_name_list
    @tags = TagGossip.find_tags_id(params[:gossip_id].to_i)

  end

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @user = current_user
    @users = User.full_name_list
    @tags = TagGossip.find_tags_id(params[:gossip_id].to_i)
    @comment = Comment.new(comment_params.merge(commentable: @gossip))
      if @comment.save
        # @comments = Comment.where(gossip_id: params[:gossip_id])
        redirect_to gossip_path(@gossip), notice: "Comment was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  def update
    @gossip = Gossip.find(params[:gossip_id])
    @comment = Comment.find(params[:id])
    @usergossip = User.find(@gossip.user_id)  
    @usercomment = User.find(@comment.user_id)
    @users = User.full_name_list
    @tags = TagGossip.find_tags_id(params[:gossip_id].to_i)
    @comment = Comment.find(params[:id])

      if @comment.update(comment_params)
        redirect_to gossip_path(@gossip), notice: "Comment was successfully updated."

      else
        render :edit, status: :unprocessable_entity
      end
  end

  def destroy
    @comment.destroy
    @gossip = Gossip.find(params[:gossip_id])
    redirect_to gossip_path(@gossip), notice: "Comment was successfully destroyed."
  end

  private

    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :content)
    end

end
