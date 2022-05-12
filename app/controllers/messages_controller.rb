class MessagesController < ApplicationController
  
  def index
  end

  def new
    @users = User.full_name_list
  end

  def create
  end

  def show
  end

  def destroy
  end
end
