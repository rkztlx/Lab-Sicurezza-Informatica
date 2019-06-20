class ReviewsController < ApplicationController

    before_action :authenticate_user!
    
    def index
        @reviews = Place.all
    end
    
    def show
        begin
            id = params[:id] # retrieve review ID from URI route
            @review = Review.find(id) # look up review by unique ID
        # will render app/views/reviews/show.html.haml by default
        rescue ActiveRecord::RecordNotFound
            redirect_to :controller => "reviews", :action => "index"
            flash[:warning] = "There is no review with that index"
            return
        end
    end

    def new
        # default: render ’new’ template
    end

    def create
        id_place = params[:place_id]
		@place = Place.find(id_place)
		@user = current_user
		@review = @place.reviews.create!(params[:review].permit(:rating, :comments, :user))
		@review.user_id = @user.id
		@review.save!
		flash[:notice] = "A review has from #{@user.email} been successfully added to #{@place.title}."
		#id_user = params[:review][:moviegoer_id]
		#@user = Moviegoer.find(id_user)
		#@review = @movie.reviews.create!(params[:review].permit(:potatoes, :comments, :moviegoer_id))
        #flash[:notice] = "A review has from #{@user.name} been successfully added to #{@movie.title}."
        respond_to do |client_wants|
            client_wants.html { flash[:notice] = "review was successfully added." }
            client_wants.xml { render :xml => @review.to_xml }
		redirect_to place_path(@place)
        end
    end

    

    def edit
        @review = Review.find params[:id]
    end

    def update
        @review = Review.find params[:id]
        @review.update_attributes!(params[:review].permit(:description))
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "#{@review.description} was successfully added."
                redirect_to review_path(@review)
            }
            client_wants.xml { render :xml => @review.to_xml }
        end
    end

    def destroy
        id = params[:id]
        #@movie = Movie.find(id)
		#@movie.destroy
		#flash[:notice] = "#{@movie.title} has been deleted."
		#redirect_to movies_path
		id_place = params[:place_id]
		@place = Place.find(id_place)
		@review = Review.find(id)
		@review.destroy
		flash[:notice] = "Your review has been deleted."
		redirect_to place_path(@place)
    end

end
