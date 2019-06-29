class UsersController < ApplicationController

    before_action :authenticate_user!
    
    def index
        if current_user.is? :admin
            @users = User.all
        else
            flash[:warning] = "You cannot have access to the list of all users"
            redirect_to root_path
        end
    end
    
    def show
        begin
            id = params[:id] #retrieve user ID from URI route
            @user = User.find(id) # look up id bi unique ID
            authorize! :read, @user, :message => "BEWARE: You are not authorized to read an user."
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
        authorize! :update, @user, :message => "BEWARE: You are not authorized to edit an user."
        if current_user != @user
            flash[:warning] = "You are not authorized to edit this user"
            redirect_to user_path(@user)
        end
    end

    def update
        @user = User.find params[:id]
        authorize! :update, @user, :message => "BEWARE: You are not authorized to update an user."
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
        if (@user.id == current_user.id || (current_user.is?(:admin) && !@user.is?(:admin)))
            @user.destroy
            flash[:notice] = "User #{@user.name} deleted."
        elsif (current_user.is?(:admin) && @user.is?(:admin))
            flash[:warning] = "You cannot delete another admin's profile"
        else
            flash[:warning] = "You cannot delete another user's profile"
        end
        redirect_to places_path
    end

    def favorite
        @user = User.find(params[:id])
        authorize! :update, @user, :message => "BEWARE: You are not authorized to update an user."
        @place = Place.find(params[:place_id])
        @user.favorite_place = @place
        @user.save!
        flash[:notice] = "Place #{@place.name} has been set as your favorite"
        redirect_to place_path(@place)
    end

    def reviews
        @user = User.find(params[:id])
        @reviews = @user.reviews
        # authorize! :read, @reviews, :message => "BEWARE: You are not authorized to read a review."
        # default: render ’reviews’ template
    end

    def ban
        if current_user.is? :admin
            @user = User.find(params[:id])
            @user.roles = @user.roles << :banned
            @user.save!
            flash[:notices] = "The user #{@user.name} has been successfully banned"
        else
            flash[:warning] = "You cannot ban another user"
        end
        redirect_to user_path(@user)
    end

    def unban
        if current_user.is? :admin
            @user = User.find(params[:id])
            @user.roles = @user.roles.reject{ |k| k==:banned}
            @user.save!
            flash[:notices] = "The user #{@user.name} has been successfully unbanned"
        else
            flash[:warning] = "You cannot unban another user"
        end
        redirect_to user_path(@user)
    end

    def promote
        if current_user.is? :admin
            @user = User.find(params[:id])
            if params[:role] == "Moderator"
                @user.roles = @user.roles << :moderator
                @user.save!
                flash[:notices] = "The user #{@user.name} has benn successfully promoted as moderator"
            else
                if !@user.is? :moderator
                    @user.roles = @user.roles << :moderator
                end
                @user.roles = @user.roles << :admin
                @user.save!
                flash[:notices] = "The user #{@user.name} has benn successfully promoted as admin"
            end
        else
            flash[:warning] = "You cannot promote another user"
        end
        redirect_to user_path(@user)
    end

    def demote
        if current_user.is? :admin
            @user = User.find(params[:id])
            if params[:role] == "Moderator"
                @user.roles = @user.roles.reject{ |k| k==:moderator}
                @user.save!
                flash[:notices] = "The user #{@user.name} has been successfully demoted from moderator"
            end
        else
            flash[:warning] = "You cannot demote another user"
        end
        redirect_to user_path(@user)
    end
    
    def user_params_create
        params[:user].permit(:name, :surname, :birth_date, :nickname, :email, :password, :password_confirmation, :bio)
    end
    
    def user_params_update
        params[:place].permit(:name, :surname, :birth_date, :nickname, :email, :password, :password_confirmation, :favorite_places, :bio)
    end

end
