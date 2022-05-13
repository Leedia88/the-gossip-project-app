class UserController < ApplicationController

def index
    @users = User.all
end

def show
    @user = User.find(params[:id])
    @gossips = Gossip.where(user: @user)
end

def new
    @cities = City.name_list
    @user = User.new

end

def create
    puts params
    @cities = City.name_list
    @user = User.new(user_params)
    if @user.save
        session[:user_id] = @user.id
        redirect_to gossip_index_path
    else
        flash[:alert]= "User not saved"
        render :new
    end
end

def contact
    @contact = User.find(params[:id])
end

def choose_contact
    @users = User.all
end

private

def user_params
    params.require(:user).permit(:first_name, :last_name, :city_id, :age, :email, :description, :password, :password_confirmation)
end

end
