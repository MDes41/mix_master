class ArtistsController < ApplicationController

  def index

  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.create(artist_params)
    redirect_to @artist
  end

  def show
    @artist = Artist.find(params[:id])
    byebug
  end

  private

  def artist_params
    params.require(:artist).permit(:name, :image_path)
  end
end
