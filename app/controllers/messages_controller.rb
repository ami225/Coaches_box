class MessagesController < ApplicationController
  def create
  #form_withで送られてきたパラメータを確認
  #messageとroom_idが入っているか条件分岐
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @user_message = UserMessage.create(params.require(:message).permit(:user_id, :message_id).merge(user_id: current_user.id))
      if Message.create!(params.require(:message).permit(:room_id, :content))
        #coach_messageをcreateする(coachがメッセージを送った場合)
        #user_messageのcreateする(userがメッセージを送った場合)
        @message = Message.new
        gets_entries_all_messages
      end
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
  end
  
  private
  #22行目に「@messages = @room.messages.includes(:user).order("created_at asc")」この文はuserとcoachが記述できてから
  def gets_entries_all_messages
    @room = Room.find(params[:message][:room_id])
    @messages = @room.messages.order("created_at asc")
    @entries = @room.entries
  end
end
