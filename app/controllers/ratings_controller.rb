class RatingsController < ApplicationController

  #<a href="/games/<%= game.id %>/add" value="<%= game.id %>"> Your rating: <%= game.ratings.value %></a>

  get '/games/:id/add_rating' do
    @game = Game.find(params[:id])
    erb :'ratings/create_rating'
  end

  post '/games/:id/add_rating' do
    @game = Game.find(params[:id])
    @user = current_user(session)
    #@rating = Rating.where(user_id: '@user.id', game_id: '@game.id')

    binding.pry
  end
end
