class RatingsController < ApplicationController

  get '/games/:id/add_rating' do
    @game = Game.find(params[:id])
    erb :'ratings/create_rating'
  end

  post '/games/:id/add_rating' do
    if (0..10).include?(params[:rating_value].to_i)
      @game = Game.find(params[:id])
      @rating = Rating.find_by(:user_id => current_user.id, :game_id => @game.id)
      @rating.rating_value = params[:rating_value]
      @game.ratings << @rating
      current_user.ratings << @rating
      redirect to '/games'
    else
      redirect to '/games/:id/add_rating'
    end
  end

  get '/games/:id/edit_rating' do
    if is_logged_in?
      @game = Game.find(params[:id])
      @rating = Rating.find_by(:user_id => current_user.id, :game_id => @game.id)
      if current_user.id == @rating.user_id && @rating
        erb :'/ratings/edit_rating'
      else
        redirect to '/games'
      end
    else
      redirect to '/login'
    end
  end

  patch '/games/:id' do
    @game = Game.find(params[:id])
    @rating = Rating.find_by(:user_id => current_user.id, :game_id => @game.id)
    if (0..10).include?(params[:rating_value].to_i)
      @rating.update(:rating_value => params[:rating_value])
    end
    redirect to '/games'
  end

  delete '/games/:id' do
    if is_logged_in?
      @game = Game.find(params[:id])
      @rating = Rating.find_by(:user_id => current_user.id, :game_id => @game.id)
      if current_user.id == @rating.user_id
        @rating.rating_value = nil
        @rating.save
      end
      redirect to '/games'
    else
      redirect to '/login'
    end
  end
end
