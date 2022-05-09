class UserController < ApplicationController

def index
    @users = User.all
end

def show
    @user = User.find(params[:id])
    @gossips = Gossip.where(user: @user)
end

def contact
    @contact = User.find(params[:id])
end

def choose_contact
    @users = User.all
end

end
