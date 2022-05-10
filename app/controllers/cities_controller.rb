class CitiesController < ApplicationController

    before_action set_city :set_city, only: %i[ show edit update destroy ]

    def index
        @cities = City.all
    end

    def show
        
    end

    private

    def set_city
        @city = City.find(params[:id])
    end



end
