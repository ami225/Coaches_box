class FindersController < ApplicationController
  def finder
    # search = params[:search],word = params[:word]これらを8行目にまとめて書く
    # @rangeにはpostかcoachが入っているので７行目でそれを分岐
    @range = params[:range]
    # Coachかpostか条件分岐
    if @range == "Coach"
      # coachから探す(coach.rbのlooks_forメソッドから探してきて、@coachesに検索結果を代入)
      @coaches = Coach.looks_for(params[:search], params[:word])
    else
      # postから探す(post.rbのlooks_forメソッドから探してきて、@postsに検索結果を代入)
      @posts = Post.looks_for(params[:search], params[:word])
    end
  end
end
