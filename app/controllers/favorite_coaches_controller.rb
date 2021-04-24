class FavoriteCoachesController < ApplicationController
  before_action :authenticate?
  def index
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id)
  end
  
  private
   #ログインしていないuserとcoachはトップ画面に戻る
  def authenticate?
    #!で反転させる意味 ()の中が優先され、サインインしていない場合がtrueとなりredirect_toになる
    if !(user_signed_in? || coach_signed_in?)
      redirect_to root_path
    end
  end
end
