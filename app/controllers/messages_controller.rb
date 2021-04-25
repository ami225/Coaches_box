class MessagesController < ApplicationController
  before_action :authenticate?
  def create
    @room = Room.find(params[:message][:room_id])
    @message = Message.new(message_params)
    # メッセージがuserによるものだったらis_user=true, shopによるものだったらis_user=false
    if user_signed_in?
      @message.is_user = true
    elsif coach_signed_in?
      @message.is_user = false
    end
    @message.room_id = @room.id
    if @message.save
      redirect_to room_path(@room)
    else
      redirect_to room_path(@room)
    end
  end

  private

  # ログインしていないuserとcoachはトップ画面に戻る
  def authenticate?
    # !で反転させる意味 ()の中が優先され、サインインしていない場合がtrueとなりredirect_toになる
    if !(user_signed_in? || coach_signed_in?)
      redirect_to root_path
    end
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
