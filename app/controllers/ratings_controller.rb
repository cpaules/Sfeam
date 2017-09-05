class RatingsController < ApplicationController

  #TODO:
  #homepage should show the avg rating for each game
  #users page should show their rating for each game they own, if they havent rated it yet, then it should be a link to create a new rating

  get '/games/:id/add_rating' do
    @game = Game.find(params[:id])
    erb :'ratings/create_rating'
  end

  post '/games/:id/add_rating' do #error upon creating a rating
    @game = Game.find(params[:id])
    @user = current_user(session)
    @rating = Rating.find_by(:user_id => @user.id, :game_id => @game.id)
    @rating.rating_value = params[:rating_value]
    @game.ratings << @rating
    @user.ratings << @rating
  end
end
