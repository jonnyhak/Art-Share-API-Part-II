
class LikesController < ApplicationController

    def index
        if params.has_key?(:artwork_id)
            likes = Like.where(likeable_type: 'Artwork', likeable_id: params[:artwork_id])
        else
            likes = Like.where(likeable_type: 'Comment', likeable_id: params[:comment_id])
        end
        render json: likes
    end

    def create
        like = Like.new(like_params)
        if like.save
            render json: like
        else
            render json: like.errors.full_messages, status: :unprocessable_entity
        end 
    end

    def destroy
        like = Like.find(params[:id])
        like.destroy
        render json: like
    end

    private

    def like_params
        params.require(:like).permit(:liker_id, :likeable_type, :likeable_id)
    end


end


