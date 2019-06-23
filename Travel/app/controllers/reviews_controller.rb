class ReviewsController < ApplicationController

    before_action :authenticate_user!

    def new
        # default: render ’new’ template
    end

    def create
        id_place = params[:place_id]
		@place = Place.find(id_place)
        @user = current_user
        @user.reviews << @place.reviews.build(params[:review].permit(:rating, :comments))
		##authorize! :create, @review, :message => "BEWARE: You are not authorized to create new reviews."
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "A review has from #{@user.email} been successfully added to #{@place.name}."
                redirect_to place_path(@place)
            }
            client_wants.xml { render :xml => @review.to_xml }
        end
    end

    
    ##def edit
        ##@review = Review.find params[:id]
    ##end

    ##def update
        ##@review = Review.find params[:id]
        ##@review.update_attributes!(params[:review].permit(:description))
        ##respond_to do |client_wants|
            ##client_wants.html {
                ##flash[:notice] = "#{@review.description} was successfully added."
                ##redirect_to review_path(@review)
            ##}
            ##client_wants.xml { render :xml => @review.to_xml }
        ##end
    ##end

    def destroy
        id = params[:id]
		id_place = params[:place_id]
		@place = Place.find(id_place)
		##authorize! :destroy, @review, :message => "BEWARE: You are not authorized to delete reviews."
		@review = Review.find(id)
		@review.destroy
		flash[:notice] = "Your review has been deleted."
		redirect_to place_path(@place)
    end

    ##def like
		##id_place = params[:place_id]
		##id_review = params[:id]
		##review = Review.find(id_review)
		##if review.likes.present?
			##l = review.likes + 1
		##else
			##l = 1
		##end
		##review.update(likes: l)
		##redirect_to place_path(id_place)
    ##end
    
    def dislike
		id_place = params[:place_id]
		id_review = params[:id]
		review = Review.find(id_review)
		if review.dislikes.present?
			l = review.dislikes + 1
		else
			l = 1
		end
		review.update(dislikes: l)
		redirect_to place_path(id_place)
	end

end
