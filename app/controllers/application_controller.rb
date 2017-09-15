require './config/environment'

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

end
