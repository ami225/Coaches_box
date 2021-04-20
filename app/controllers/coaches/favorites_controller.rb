class Coaches::FavoritesController < ApplicationController
  def index
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id).all
  end

  def create
    @coach = Coach.find(params[:coach_id])
    favorite = current_user.favorites.new(coach_id: @coach.id)
    favorite.save
  end

  def destroy
    @coach = Coach.find(params[:coach_id])
    favorite = current_user.favorites.find_by(coach_id: @coach.id)
    favorite.delete
  end
end
