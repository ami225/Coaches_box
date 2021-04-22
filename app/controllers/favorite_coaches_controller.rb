class FavoriteCoachesController < ApplicationController
  def index
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id)
  end
end
