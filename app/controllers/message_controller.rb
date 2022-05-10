class MessageController < ApplicationController
  
  def index

  end

  def new
    @users = User.full_name_list
  end

end

