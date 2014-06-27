class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_crmuser!

  #before_filter :update_sanitized_params, if: :devise_controller?

  layout :layout_by_resource

  def layout_by_resource
    if devise_controller? and !crmuser_signed_in?
      'auth'
    else
      'application'
    end
  end

  # protected
  #   def update_sanitized_params

  #     devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
  #   end
end
