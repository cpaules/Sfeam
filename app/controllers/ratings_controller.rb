class RatingsController < ApplicationController

  get '/games/:id/add_rating' do
    @game = Game.find(params[:id])
    erb :'ratings/create_rating'
  end

  post '/games/:id/add_rating' do
    if [0,1,2,3,4,5,6,7,8,9,10].include?(params[:rating_value].to_i)
      @game = Game.find(params[:id])
      @user = current_user(session)
      @rating = Rating.find_by(:user_id => @user.id, :game_id => @game.id)
      @rating.rating_value = params[:rating_value]
      @game.ratings << @rating
      @user.ratings << @rating
      redirect to '/games'
    else
      redirect to '/games/:id/add_rating'
    end
  end
end
