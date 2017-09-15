module HelperMethods

  private

  def current_user
    if @current_user
      @current_user
    else
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  def is_logged_in?
    !!current_user
  end

end
