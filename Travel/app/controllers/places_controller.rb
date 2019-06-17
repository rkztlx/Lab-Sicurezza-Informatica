class PlacesController < ApplicationController
    
    def index
        @places = Place.all
    end
    
    def show
        id = params[:id] # retrieve movie ID from URI route
        @place = Place.find(id) # look up movie by unique ID
        # will render app/views/places/show.html.haml by default
    end

    def new
        # default: render ’new’ template
    end

    def create
        @place = Place.create!(params[:place])
        flash[:notice] = "#{@place.name} was successfully created."
        redirect_to places_path
    end

end
