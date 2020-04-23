class ArtworksController < ApplicationController

    def index
        shared = Artwork
                .joins(:shares)
                .where(artwork_shares: {viewer_id:params[:user_id]})
                .pluck(:id) 
        artworks = Artwork.where(artist_id: params[:user_id]).or(Artwork.where(id: shared))
        render json: artworks
    end

    def favorites
        shared = Artwork
                .joins(:shares)
                .where(artwork_shares: {viewer_id:params[:user_id], favorite: true})
                .pluck(:id) 
        artworks = Artwork.where(artist_id: params[:user_id], favorite: true).or(Artwork.where(id: shared))
        render json: artworks
    end

    def favorite 
        artwork = Artwork.find(params[:id])
        toggle = artwork.favorite ? 'f' : 't'
        if artwork.update(favorite: toggle) 
            render json: artwork
        else    
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end
    end

    def create
        artwork = Artwork.new(artwork_params)
        if artwork.save
            render json: artwork
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end 
    end

    def show
        artwork = Artwork.find(params[:id])
        render json: artwork 
    end

    def update
        @artwork = Artwork.find(params[:id])
        artwork = @artwork.update(artwork_params)
        if artwork
            redirect_to artwork_url(@artwork.id)
        else
            render json: artwork.errors.full_messages, status: :unprocessable_entity
        end 
    end

    def destroy
        @artwork = Artwork.find(params[:id])
        @artwork.destroy
        render json: @artwork
    end

    private

    def artwork_params
        params.require(:artwork).permit(:title, :image_url, :artist_id)
    end

end