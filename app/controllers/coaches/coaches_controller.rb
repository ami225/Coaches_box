class Coaches::CoachesController < ApplicationController
    
    def show
      @coach = current_coach
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
