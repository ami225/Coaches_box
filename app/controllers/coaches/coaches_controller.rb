class Coaches::CoachesController < ApplicationController
    
    def show
       #コーチがログイン
      if coach_signed_in?
       @coach = Coach.find(params[:id])
       #コーチに紐づいた投稿
       @posts = @coach.posts
       rooms = current_coach.rooms
       #自分が入ってるroomの相手のidを格納する
       @user_ids = []
       rooms.each do |r|
       @user_ids << r.user_id
      end
      #ユーザーがログイン
      elsif user_signed_in?
       @coach = Coach.find(params[:id])
       @posts = @coach.posts
       rooms = current_user.rooms
       #自分が入ってるroomの相手のidを格納する
       @coach_ids = []
       rooms.each do |r|
       @coach_ids << r.coach_id
      end
      end
    end
      
    def index
     @user = User.find_by(id: params[:id])
     @favorites = Favorite.where(user_id: @userid)
    end
    
    
    def edit
      @coach = current_coach
    end
    
    def update
      @coach = current_coach
      tag_list = params[:coach][:tag_ids].split(",")
     if @coach.update(coach_params)
       @coach.save_tags(tag_list)
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
       params.require(:coach).permit(tag_ids[], :coach)
     end
end
