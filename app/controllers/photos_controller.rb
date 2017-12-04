class PhotosController < ApplicationController
 before_action :authenticate_user!

  def index
      @photos = Photo.all
      @like = {}
      @photos.each do |photo|
          @vote = Vote.where(photo_id: photo.id).sum(:like)
          @like[photo.id] = @vote
        
      end
  end

  def new
  	@photo = Photo.new 
  end
  def create
  	params[:photo][:category_id] = params[:category_id]
  	params[:photo][:user_id] = current_user.id
    @photo = Photo.create(photos_params)	
    redirect_to photos_path
  end
  
  def edit
  	
  end

  def update
  	
  end

  def destroy
  	
  end

  def vote
    @photo = Photo.find(params[:id])
    @vote = Vote.where(user_id: current_user.id, photo_id: @photo.id).first
    if @vote == nil
      @like = 1
      Vote.create(user_id: current_user.id, photo_id: @photo.id, like: @like)
    else
      @vote.destroy
    end
    redirect_to photos_path
end

  private
def photos_params
  params.require(:photo).permit(:user_id, :category_id, :name, :photo)
end

end