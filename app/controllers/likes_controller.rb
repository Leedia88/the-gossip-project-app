class LikesController < ApplicationController
  before_action :set_gossip, only: %i[create, destroy]

  def create
    puts params
    @gossip = Gossip.find(params[:gossip_id])
    like = Like.create!(gossip: @gossip, user: current_user)
    if like.save
      puts params
      # redirect_to :back
      redirect_to gossip_path(@gossip)
    else
      puts params
      redirect_to root_path
    end
  end

  def destroy
    @gossip = Gossip.find(params[:gossip_id])
    @gossip.get_like(current_user).destroy
    redirect_to gossip_path(@gossip)
  end

  def set_gossip
    @gossip = Gossip.find(params[:gossip_id])
  end

end
