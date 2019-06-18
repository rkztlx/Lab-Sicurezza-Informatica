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
        @user = User.create!(params[:user])
        if @user.save
            flash[:succss] = "#{@user.nickname} was successfully created."
            redirect_to users_path
        else
            render 'new'
        end
    end
    
end
