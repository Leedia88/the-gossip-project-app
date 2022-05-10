class GossipController < ApplicationController

    def index
        @gossips = Gossip.all.order(:id)
    end

    def search
        @gossips = Gossip.search(params[:search])
    end

    def show
        @gossip = Gossip.find(params[:id])
        @user = User.find(@gossip.user_id)
        @tags = TagGossip.find_tags_id(params[:id].to_i)
    end

    def new
        @users = User.full_name_list
        @gossip = Gossip.new
    end

    def create
        @users = User.full_name_list
        @gossip = Gossip.new(gossip_params)
        if @gossip.save
            redirect_to gossip_index_path, notice: "Gossip Created"
        else
            render :new
        end
    end

    def edit
        @gossip = Gossip.find(params[:id])
        @user = User.find(@gossip.user_id)
    end

    def update
        @gossip = Gossip.find(params[:id])
        if @gossip.update(gossip_params)
            redirect_to @gossip, notice: "Gossip Updated"
        else
            render :edit
        end
    end

    def search
        @gossips = Gossip.search(params[:search])
    end

    private 
    
    def gossip_params
        params.require(:gossip).permit(:title, :content, :user_id)
    end

end
