class GossipController < ApplicationController
    before_action :set_gossip, only: %i[ show edit update destroy ]

    def index
        @gossips = Gossip.all.order(:id)
    end

    def search
        @gossips = Gossip.search(params[:search])
    end

    def show
        @comments = @gossip.comments
        @users = User.full_name_list
        @user = User.find(@gossip.user_id)
        @tags = TagGossip.find_tags_id(@gossip)
        @comment = Comment.new
    end

    def new
        unless logged_in?
            flash[:warning] = "You should log in to gossip!"
            redirect_to new_session_path
        end
        @users = User.full_name_list
        @gossip = Gossip.new
        @tags = Tag.all
    end

    def create
        tag_param = params[:tags_id]
        @gossip = Gossip.new(gossip_params)
            if @gossip.user == current_user
                if @gossip.save
                    tag_param.each do |tag_id|
                        TagGossip.new(tag_id: tag_id, gossip_id: @gossip.id)
                    end
                    flash[:success] = "Gossip Created"
                    redirect_to gossip_index_path
                else
                    flash[:danger] = "Error : gossip not saved"
                    render :new
                end
            else
                flash[:danger] = "Error with user selected"
                render :new
            end
    end

    def edit
        @user = User.find(@gossip.user_id)
        @tags_ids = TagGossip.find_tags_id(@gossip)
        @tags = Tag.all
    end

    def update
        if @gossip.update(gossip_params)
            redirect_to @gossip, notice: "Gossip Updated"
        else
            render :edit
        end
    end

    def destroy
        @gossip.destroy
        flash[:warning] = "Gossip deleted"
        redirect_to gossip_index_path
    end


    def search
        @gossips = Gossip.search(params[:search])
    end

    private 
    
    def set_gossip
        @gossip = Gossip.find(params[:id])
    end 

    def gossip_params
        params.require(:gossip).permit(:title, :content, :user_id)
    end

    def authenticate_user
        unless current_user
          flash[:danger] = "Pour y accèder, tu dois être connectée!"
          redirect_to new_session_path
        end
    end

end
