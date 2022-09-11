class PhotosController < ApplicationController
  def destroy
    @photo = Photo.find(params[:id])
    home = @photo.home

    @photo.destroy
    @photos = Photo.where(home_id: home.id)
    respond_to :js
  end
end