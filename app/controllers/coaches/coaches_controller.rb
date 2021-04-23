class Coaches::CoachesController < ApplicationController
  # コーチのみ編集と削除ができる
  before_action :authenticate_coach!
  before_action :ensure_correct_coach, only: [:edit]
  def show
    @coach = Coach.find(params[:id])
    # コーチに紐づいた投稿
    @posts = @coach.posts
    rooms = current_coach.rooms
    # 自分が入ってるroomの相手のidを格納する
    @user_ids = []
    rooms.each do |r|
      @user_ids << r.user_id
    end
  end

  def index
    # タグで検索をかけたらparams[:tag_id].present? が作動して、検索かけていない時はその後ろが動く
    @coaches = params[:tag_id].present? ? Tag.find(params[:tag_id]).coaches : Coach.all
  end

  def edit
    @coach = Coach.find(params[:id])
    # ログインしているコーチのプロフィールのみ編集可能
    if @coach.is_same?(current_coach)
      render :edit
    else
      redirect_to coaches_coach_path
    end
  end

  def update
    @coach = current_coach
    # tag_listにcoach_id, tag_idsを入れる。複数の場合はコンマで区切るようにする
    tag_list = params[:coach][:tag_ids].split(",")
    if @coach.update(coach_params)
      @coach.save_tags(tag_list)
      flash[:notice] = "プロフィールを編集しました。"
      redirect_to coaches_coach_path
    else
      render :edit
    end
  end

  private

  def coach_params
    params.require(:coach).permit(:name, :introduction, :profile_image)
  end

  def tag_params
    params.require(:coach).permit(tag_ids[], :coach, :tag_id)
  end

  def ensure_correct_coach
    @coach = Coach.find(params[:id])
    unless @coach == current_coach
      redirect_to coaches_coach_path(current_coach.id)
    end
  end
end
