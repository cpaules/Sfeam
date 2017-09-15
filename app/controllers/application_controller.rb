require './config/environment'
require 'pry'

class ApplicationController < Sinatra::Base
  include HelperMethods

  configure do
    enable :sessions
    set :session_secret, "secret"
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    @games = Game.all
    erb :index
  end

end
