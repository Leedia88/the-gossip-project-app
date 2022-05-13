class GossipController < ApplicationController
    before_action :set_gossip, only:[ :show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:new, :create]
    before_action :authenticate_current_user, only: [:edit, :update, :destroy]

    def index
        @gossips = Gossip.search(params[:search]).order(:id)
    end

    def search
        @gossips = Gossip.all.order(:id)
    end

    def show
        @comments = @gossip.comments
        @users = User.full_name_list
        @user = User.find(@gossip.user_id)
        @tags = TagGossip.find_tags(@gossip)
        @comment = Comment.new
        @city = City.find(@user.city_id)
        if @gossip.is_liked?(@user)
            @like = @gossip.get_like(@user)
        end
    end

    def new
        puts params
        @users = User.full_name_list
        @gossip = Gossip.new
        @tags = Tag.all
    end

    def create
        puts params
        tag_param = params[:tags_id]
        @gossip = Gossip.new(gossip_params)
                if @gossip.save
                    if tag_param
                        tag_param.each do |tag_id|
                            TagGossip.create(tag_id: tag_id, gossip_id: @gossip.id)
                        end
                    end
                    flash[:success] = "Gossip Created"
                    redirect_to gossip_index_path
                else
                    flash[:danger] = "Error : gossip not saved"
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
        unless logged_in?
          flash[:warning] = "You should log in to gossip!"
          redirect_to new_session_path
        end
    end

    def authenticate_current_user
        unless log_in(@gossip.user)
          flash[:warning] = "You are not authorized to modify/delete this gossip!"
          redirect_to gossip_index_path
        end
    end

end
