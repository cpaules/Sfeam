require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  include Concerns::HelperMethods

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    erb :index
  end

  get '/games/new' do
    erb :'games/create_game'
  end

  post '/games/new' do
    if params[:name] != ""
      @game = Game.create(params)
      @game.ratings.delete_all
      redirect to '/'
    end
    redirect to '/games/new'
  end

  get '/games' do
    @user = current_user(session)
      if is_logged_in?(session) && @user
      erb :'/games/games'
    else
      redirect to "/login"
    end
  end

  get '/games/:id/add' do
    if is_logged_in?(session)
      @game = Game.find(params[:id])
      @user = current_user(session)
      if @user.games.include?(@game)
        redirect to '/games'
      else
        @user.games << @game
        redirect to '/games'
      end
    else
      redirect to '/login'
    end
  end



end
