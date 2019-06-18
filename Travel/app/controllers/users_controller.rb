class UsersController < ApplicationController
    
    def index
        @users = User.all
    end
    
    def show
        id = params[:id] #retrieve user ID from URI route
        @user = User.find(id) # look up id bi unique ID
    end
    
    def new
        # default: render ’new’ template
    end

    def create
        @user = User.create!(params[:user].permit(:name, :surname, :birth_date, :nickname, :email, :bio))
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "#{@user.name} was successfully created."
                redirect_to users_path
            }
            client_wants.xml { render :xml => @user.to_xml }
        end
    end

    def edit
        @user = User.find params[:id]
    end

    def update
        @user = User.find params[:id]
        @user.update_attributes!(params[:place].permit(:name, :surname, :birth_date, :nickname, :email, :favorite_places, :bio))
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
        @user.destroy
        flash[:notice] = "User #{@user.name} deleted."
        redirect_to users_path
    end
end
