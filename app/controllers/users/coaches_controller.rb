class Users::CoachesController < ApplicationController
    
   def show
     @coach = Coach.find(params[:id])
     @room = Room.new
     @room = Room.all
   end
end
