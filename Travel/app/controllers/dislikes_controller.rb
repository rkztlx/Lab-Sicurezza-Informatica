class DislikesController < ApplicationController
    
    before_action :find_review
    before_action :find_dislike, only: [:destroy]
    
    def create
        @review.dislikes.create(user_id: current_user.id)
        @like = @review.likes.where(["user_id = ?", current_user.id]).first
        if !@like.nil?
            @review.likes.destroy(@like.id)
        end
        redirect_to place_path(Place.find(params[:place_id]))
    end

    def destroy
        if !(already_disliked?)
            flash[:notice] = "Cannot undislike"
        else
            @dislike.destroy
        end
        redirect_to place_path(Place.find(params[:place_id]))
    end
    
    private
    
    def find_review
        @review = Review.find(params[:review_id])
    end

    def find_dislike
        @dislike = @review.dislikes.find(params[:id])
    end

    def already_disliked?
        Dislike.where(user_id: current_user.id, review_id: params[:review_id]).exists?
    end

end
