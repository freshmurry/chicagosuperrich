class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update]

  def index
    @homes = current_user.homes
  end

  def show
    @photos = @home.photos

    # @booked = Reservation.where("home_id = ? AND user_id = ?", @home.id, current_user.id).present? if current_user

    @reviews = @home.reviews
    @hasReview = @reviews.find_by(user_id: current_user.id) if current_user
  end

  def new
    @home = current_user.homes.build
  end

  def create
    @home = current_user.homes.build(home_params)

    if @home.save

      if params[:images]
        params[:images].each do |image|
          @home.photos.create(image: image)
        end
      end

      @photos = @home.photos
      redirect_to edit_home_path(@home), notice: "Saved..."
    else
      render :new
    end
  end

  def edit
    if current_user.id == @home.user.id
      @photos = @home.photos
    else
      redirect_to root_path, notice: "You don't have permission."
    end
  end

  def update
    if @home.update(home_params)

      if @home.save
        if params[:images]
          params[:images].each do |image|
            @home.photos.create(image: image)
          end
        end

      redirect_to edit_home_path(@home), notice: "Updated..."
      else
        render :edit
      end
    end
  end

  private
    def set_home
      @home = Home.find(params[:id])
    end
    
    def home_params
      params.require(:home).permit(:home_type, :bedroom, :bathroom, :listing_name, :summary, :address, :price, :active)
    end
end