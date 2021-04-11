class Coaches::CoachesController < ApplicationController
    
    def show
      @coach = current_coach
    end
    
    def chat
      @coach = Coach.find(params[:id])
      #Entryテーブルにログインユーザーとアドバイスを受けたいコーチの情報を入れる
      @currentUserEntry = Entry.where(user_id: current_user.id)#ログインしているユーザーを探す
      @coachEntry = Entry.where(user_id: @coach.id)#チャット行いたいコーチを探す
      #すでにroomが作成されている同士かどうか条件分岐
      @currentUserEntry.each do |cu|
        @coachEntry.each do |u|
          #room_idが共通しているユーザーとコーチにroom_idの変数を入れる。
          if cu.room_id == u.room_id then
            #@isRoom = falseの時、つまりRoomを作成する時に記述する用
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
    
    def edit
      @coach = current_coach
    end
    
    def update
      @coach = current_coach
     if @coach.update(coach_params)
       redirect_to coaches_coaches_my_page_path
     else
       render :edit
     end
    end
    
     private 
    
    def coach_params
      params.require(:coach).permit(:name, :introduction, :profile_image)
    end
end
