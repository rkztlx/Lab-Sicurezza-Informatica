class PlacesController < ApplicationController

    before_action :authenticate_user!
    
    def index
        if current_user.is? :admin
            @places = Place.all
        else
            flash[:warning] = "You are not authorized to read all places"
            redirect_to root_path
        end
    end
    
    def show
        begin
            id = params[:id] # retrieve place ID from URI route
            @place = Place.find(id)
            authorize! :read, @place, :message => "BEWARE: You are not authorized to read a place."
        rescue ActiveRecord::RecordNotFound 
            redirect_to :controller => "places", :action => "index"
            flash[:warning] = "There is no place with that index"
            return
        end
        # will render app/views/places/show.html.haml by default
    end

    def new
        # default: render ’new’ template
    end

    def create
        @owner = current_user
        @place = @owner.property.build(params[:place].permit(:name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices, :icon))
        authorize! :create, @place, :message => "BEWARE: You are not authorized to create a new place."
        @place.save!
        if !(@owner.is?(:owner))
            @owner.roles = @owner.roles << :owner
        end
        @owner.save!
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "#{@place.name} was successfully created."
                redirect_to places_path
            }
            client_wants.xml { render :xml => @place.to_xml }
        end
    end

    def edit
        @place = Place.find params[:id]
        authorize! :update, @place, :message => "BEWARE: You are not authorized to edit a place."
        if current_user != @place.user
            flash[:warning] = "You are not authorized to edit this place"
            redirect_to place_path(@place)
        end
    end

    def update
        @place = Place.find params[:id]
        authorize! :update, @place, :message => "BEWARE: You are not authorized to update a place."
        if current_user != @place.user
            flash[:warning] = "You are not authorized to update this place"
            redirect_to place_path(@place)
        end
        @place.update_attributes!(params[:place].permit(:name, :street, :address, :city, :telephone_number, :opening_time, :closing_time, :description, :notices, :icon))
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "#{@place.name} was successfully updated."
                redirect_to place_path(@place)
            }
            client_wants.xml { render :xml => @place.to_xml }
        end
    end

    def destroy
        @place = Place.find(params[:id])
        authorize! :destroy, @place, :message => "BEWARE: You are not authorized to delete a place."
        if current_user != @place.user && !current_user.is?(:moderator) && !current_user.is?(:admin)
            flash[:warning] = "You are not authorized to delete this place"
            redirect_to place_path(@place)
        end
        @place.destroy
        flash[:notice] = "Place #{@place.name} deleted."
        redirect_to places_path
    end
    
    def find
        @places = Place.where(name: params[:name])
        # authorize! :read, @places, :message => "BEWARE: You are not authorized to find a place."
    end

    def find_route
        # default: render ’find_route’ template
    end
    
    def display_route
        @facilities = params[:Facilities]
        @departureAddress = params[:From]
        @place = Place.find(params[:id])
        @desiredDestination = @place.street + ', ' + @place.address.to_s + ', ' + @place.city
        # default: render ’display_route’ template
    end

end
