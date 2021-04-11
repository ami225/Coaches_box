class RoomsController < ApplicationController
  
  def show
    @room = Room.find(params[:id])
    #entryテーブルからログインしているユーザーと紐づいているroom_idを探す
    if UserEntry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @user_entries = @room.user_entries
      @coach_entries = @room.coach_entries
    else
      redirect_back(fallback_location: root_path)
    end
  end
  #chat.html.erbで送られてきたパラメータを受け取る
  def create
    @room = Room.create
    @user_entry = UserEntry.create(room_id: @room.id, user_id: current_user.id) 
    @coach_entry = CoachEntry.create(params.require(:entry).permit(:coach_id, :room_id).merge(room_id: @room.id))
    @entry = Entry.create(room_id: @room.id, user_id: @user_entry.user_id, coach_id: @coach_entry.coach_id)
    redirect_to "/rooms/#{@room.id}"
  end
  
end
