class ReviewsController < ApplicationController

    before_action :authenticate_user!

    def new
        # default: render ’new’ template
    end

    def create
        id_place = params[:place_id]
		@place = Place.find(id_place)
        @user = current_user
        pre_avarage = @place.avarage
        @review = @place.reviews.build(params[:review].permit(:rating, :comments))
        authorize! :create, @review, :message => "BEWARE: You are not authorized to create a new review."
        @user.reviews << @review
        @review.save!
        @place.avarage = ((pre_avarage * (@place.reviews.count - 1)) + @review.rating) / @place.reviews.count
        @place.save!
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "A review has from #{@user.email} been successfully added to #{@place.name}."
                redirect_to place_path(@place)
            }
            client_wants.xml { render :xml => @review.to_xml }
        end
    end

    
    def edit
        @review = Review.find params[:id]
        authorize! :update, @review, :message => "BEWARE: You are not authorized to edit a review."
        flash[:previous_page] = request.referer
    end

    def update
        @review = Review.find params[:id]
        authorize! :update, @review, :message => "BEWARE: You are not authorized to update a review."
        @review.update_attributes!(params[:review].permit(:rating, :comments))
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "Review was successfully added."
                redirect_to flash[:previous_page]
            }
            client_wants.xml { render :xml => @review.to_xml }
        end
    end

    def destroy
        id = params[:id]
		id_place = params[:place_id]
        @place = Place.find(id_place)
        @review = Review.find(id)
		authorize! :destroy, @review, :message => "BEWARE: You are not authorized to delete a review."
		@review.destroy
		flash[:notice] = "Your review has been deleted."
		redirect_to request.referer
    end

end
