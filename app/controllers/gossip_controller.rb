class GossipController < ApplicationController

    def index
        @gossips = Gossip.all
    end

    def show
        puts params
        @gossip = Gossip.find(params[:id])
        @user = User.find(@gossip.user_id)
    end

    def new
        @users = User.full_name_list
        @gossip = Gossip.new

    end

    def create
        @users = User.full_name_list
        @gossip = Gossip.new(gossip_params)
        if @gossip.save
            redirect_to gossip_index_path
        else
            render :new
        end
        
    end

    private 
    
    def gossip_params
        params.require(:gossip).permit(:title, :content, :user_id)
    end

end
