class Users::CoachesController < ApplicationController
  before_action :authenticate_user!
  def show
    @coach = Coach.find(params[:id])
    # 自分の投稿を表示
    @posts = @coach.posts
    # コーチごとのroom詳細に飛べるように
    @room = @coach.rooms
    rooms = current_user.rooms
    # 自分が入ってるroomの相手のidを格納する
    @coach_ids = []
    rooms.each do |r|
      @coach_ids << r.coach_id
    end
  end

  def index
    # タグで検索をかけたらparams[:tag_id].present? が作動して、検索かけていない時はその後ろが動く
    @coaches = params[:tag_id].present? ? Tag.find(params[:tag_id]).coaches : Coach.all
  end
end
