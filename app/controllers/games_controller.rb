class GamesController < ApplicationController

  get '/games/new' do
    erb :'games/create_game'
  end

  post '/games' do
    if params[:name] != ""
      @game = Game.create(params)
      redirect to '/'
    end
    redirect to '/games/new'
  end

  get '/games' do
    if is_logged_in?
      erb :'/games/games'
    else
      redirect to "/login"
    end
  end

  post '/games/:id/add' do
    if is_logged_in?
      @game = Game.find_by(id: params[:id])
      if current_user.games.include?(@game)
        redirect to '/games'
      else
        current_user.games << @game
        redirect to '/games'
      end
    else
      redirect to '/login'
    end
  end

end
