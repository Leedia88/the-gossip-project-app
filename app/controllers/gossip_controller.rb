class GossipController < ApplicationController
    before_action :set_gossip, only:[ :show, :edit, :update, :destroy]
    before_action :authenticate_user, only: [:new, :create]
    before_action :authenticate_current_user, only: [:edit, :update, :destroy]

    def index
        @gossips = Gossip.search(params[:search]).order(:id)
        puts current_user
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
        @tags = Tag.all
        @gossip = Gossip.new(gossip_params)
                if @gossip.save
                    tags = params[:tags].split
                    if tags
                        tags.each do |tag|
                            TagGossip.create!(tag_id: Tag.get_id(tag), gossip_id: @gossip.id)
                        end
                    end
                    flash[:success] = "Gossip Created"
                    redirect_to gossip_index_path
                else
                    render :new
                end
    end

    def edit
        @user = User.find(@gossip.user_id)
        @tags_list = Tag.get_list(@gossip)
        @tags = Tag.all
    end

    def update
        if @gossip.update(gossip_params)
            tags = params[:tags].split
                    if tags #si params non vide
                        TagGossip.where("gossip_id = ?", @gossip.id).delete_all
                        tags.each do |tag| #nom du tag
                            tg = TagGossip.new(tag_id: Tag.get_id(tag), gossip: @gossip)
                            if tg.save
                            end
                        end
                    end
            flash[:success] = "Gossip Updated"
            redirect_to @gossip
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
        unless current_user == @gossip.user
          flash[:warning] = "You are not authorized to modify/delete this gossip!"
          redirect_to gossip_index_path
        end
    end

end
