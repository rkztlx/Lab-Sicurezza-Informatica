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
        @review = Review.create!(params[:review].permit(:description))
        respond_to do |client_wants|
            client_wants.html {
                flash[:notice] = "#{@review.description} was successfully added."
                redirect_to reviews_path
            }
            client_wants.xml { render :xml => @review.to_xml }
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
        @review = Review.find(params[:id])
        @review.destroy
        flash[:notice] = "Review #{@review.name} deleted."
        redirect_to review_path
    end
end
