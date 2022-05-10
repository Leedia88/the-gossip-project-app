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
        puts params.inspect
        @users = User.full_name_list
        @gossip = Gossip.new
        @tags = Tag.all
    end

    def create
        puts params.inspect
        tag_param = params[:tags_id]
        @tags = Tag.all
        @users = User.full_name_list
        @gossip = Gossip.new(gossip_params)
        if @gossip.save
            tag_param.each do |tag_id|
                puts tag_id
                tg = TagGossip.new(tag_id: tag_id, gossip_id: @gossip.id)
                if tg.save
                    flash.notice = "Tag #{Tag.find(tag_id).title} added"
                else
                    flash.alert = "Error while tag saving"
                end
            end
            redirect_to gossip_index_path, notice: "Gossip Created"
        else
            render :new, alert: "Gossip not saved"
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

    def destroy
        @gossip = Gossip.find(params[:id])
        @gossip.destroy
        redirect_to gossip_index_path
    end


    def search
        @gossips = Gossip.search(params[:search])
    end

    private 
    
    def gossip_params
        params.require(:gossip).permit(:title, :content, :user_id)
    end

end
