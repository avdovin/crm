class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter   :authorize

  helper_method :current_user, :logged_in?

  def current_user
    return unless session[:user_id]
    @current_user ||= Crm::User.find(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

  protected
    def authorize
      unless Crm::User::find_by_id(session[:user_id])
        redirect_to login_url, notice: "Пожалуйста, пройдите авторизацию"
    end
  end
end
