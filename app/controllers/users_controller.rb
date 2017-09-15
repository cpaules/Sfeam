class UsersController < ApplicationController

  get '/signup' do
   if is_logged_in?
     redirect to "/games"
   else
     erb :'/users/create_user'
   end
 end

 post '/signup' do
   user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
   if user.save
     session[:user_id] = user.id
     redirect to "/games"
   else
     redirect "/signup"
   end
  end

  get "/login" do
    if is_logged_in?
      redirect to "/games"
    else
      erb :'/users/login'
    end
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/games"
    else
      redirect "/login"
    end
  end

  get "/logout" do
    if is_logged_in?
      session.clear
      redirect to "/"
    else
      redirect to "/games"
    end
  end

end
