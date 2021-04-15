class RoomsController < ApplicationController
  
  def show
    @room = Room.find(params[:id]) #ルーム情報の取得
    @coach = @room.coach
    @user = @room.user
    @message = Message.new #新規メッセージ投稿
    @messages = @room.messages #このルームのメッセージを全て取得
    #ユーザーがログインしている時
    if user_signed_in?
      if @room.user.id == current_user.id
        @coach = @room.coach
      else
        redirect_to coaches_coach_path(@coach.id)
      end
    #コーチがログインしている時
    elsif coach_signed_in?
      if @room.coach.id == current_coach.id
        @user = @room.user
      else
        redirect_to coaches_coach_path(current_coach.id)
      end
    else
      redirect_to coaches_coach_path(current_coach.id)
    end
  end

  def create
    #userがログインしてたらuser_idを, coachがログインしてたらcoach_idを@roomにいれる
    if user_signed_in?
      @room = Room.new(room_coach_params)
      #ユーザーidを入れる
      @room.user_id = current_user.id
    elsif coach_signed_in?
      @room = Room.new(room_user_params)
      #コーチidを入れる
      @room.coach_id = current_coach.id
    else
      redirect_to coaches_coach_path(params[:room][:@coach_id])
    end
    
    if @room.save
      # redirect_to :action => "show", :coach_id => params[:room][:@coach_id], :id => @room.id
      redirect_to room_path(@room.id)
    else
      redirect_to coaches_coach_path(params[:room][:@coach_id])
    end
  end
  
  def index
    @rooms = Room.all
  end
      
    
  
  private
  def room_coach_params
    params.require(:room).permit(:coach_id)
  end

  def room_user_params
    params.require(:room).permit(:user_id)
  end
end
