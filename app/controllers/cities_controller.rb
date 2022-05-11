class CitiesController < ApplicationController

    before_action :set_city, only: %i[ show edit update destroy ]

    def index
        @cities = City.all
    end

    def show
        @gossips = Gossip.search_by_city(@city.name)
    end

    private

    def set_city
        @city = City.find(params[:id])
    end



end
