class LikesController < ApplicationController
    
    before_action :find_review
    before_action :find_like, only: [:destroy]
    
    def create
        @review.likes.create(user_id: current_user.id)
        @user = @review.user
        @user.num_likes += 1
        @dislike = @review.dislikes.where(["user_id = ?", current_user.id]).first
        if !@dislike.nil?
            @review.dislikes.destroy(@dislike.id)
            @user.num_dislikes -= 1
        end
        @user.save!
        redirect_to request.referer
    end

    def destroy
        if !(already_liked?)
            flash[:notice] = "Cannot unlike"
        else
            @like.destroy
            @user = @review.user
            @user.num_likes -= 1
            @user.save!
        end
        redirect_to request.referer
    end
    
    private

    def already_liked?
        Like.where(user_id: current_user.id, review_id: params[:review_id]).exists?
    end
    
    def find_review
        @review = Review.find(params[:review_id])
    end

    def find_like
        @like = @review.likes.find(params[:id])
    end


end
