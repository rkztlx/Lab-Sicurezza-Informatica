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
    end

    def update
        @user = User.find params[:id]
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
    
    def user_params_create
        params[:user].permit(:name, :surname, :birth_date, :nickname, :email, :password, :password_confirmation, :bio)
    end
    
    def user_params_update
        params[:place].permit(:name, :surname, :birth_date, :nickname, :email, :password, :password_confirmation, :favorite_places, :bio)
    end
end
