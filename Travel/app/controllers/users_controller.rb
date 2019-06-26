class UsersController < ApplicationController

    before_action :authenticate_user!
    
    def index
        @users = User.all
    end
    
    def show
        begin
            id = params[:id] #retrieve user ID from URI route
            @user = User.find(id) # look up id bi unique ID
        rescue ActiveRecord::RecordNotFound
            redirect_to :controller => "users", :action => "index"
            flash[:warning] = "There is no user with that index"
            return
        end
    end
    
    def new
        # default: render ’new’ template
    end

    def create
        @user = User.create!(user_params_create)
        if @user.save
            log_in @user
            flash[:success] = "Welcome on board!"
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
        @user = User.find params[:id]
        authorize! :update, @user, :message => "BEWARE: You are not authorized to edit a place."
        if current_user != @user
            flash[:warning] = "You are not authorized to edit this user"
            redirect_to user_path(@user)
        end
    end

    def update
        @user = User.find params[:id]
        authorize! :update, @user, :message => "BEWARE: You are not authorized to update this user."
        if current_user != @user
            flash[:warning] = "You are not authorized to update this user"
            redirect_to user_path(@user)
        end
        @user.update_attributes!()
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "#{@user.name} was successfully updated."
                redirect_to user_path(@user)
            }
            client_wants.xml { render :xml => @user.to_xml }
        end
    end

    def destroy
        @user = User.find(params[:id])
        if (@user.id == current_user.id) || (current_user.is? :admin)
            @user.destroy
            flash[:notice] = "User #{@user.name} deleted."
        else
            flash[:warning] = "You cannot delete another user's profile"
        end
        redirect_to places_path
    end

    def favorite
        @user = User.find(params[:id])
        @place = Place.find(params[:place_id])
        @user.favorite_place = @place
        @user.save!
        flash[:notice] = "Place #{@place.name} has been set as your favorite"
        redirect_to place_path(@place)
    end

    def reviews
        @user = User.find(params[:id])
        @reviews = @user.reviews
        # default: render ’reviews’ template
    end
        
    
    def user_params_create
        params[:user].permit(:name, :surname, :birth_date, :nickname, :email, :password, :password_confirmation, :bio)
    end
    
    def user_params_update
        params[:place].permit(:name, :surname, :birth_date, :nickname, :email, :password, :password_confirmation, :favorite_places, :bio)
    end
end
