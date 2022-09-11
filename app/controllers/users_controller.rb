class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @homes = @user.homes
  end
end