class SessionsController < ApplicationController
	skip_before_filter	:authorize

  def new
  	render layout: 'auth'
  end

  def create
  	user = Crm::User.find_by_email(params[:email])
  	if(user && user.authenticate(params[:password]))
  		session[:user_id] = user.id
  		session[:user_nickname] = user.nickname;

  		redirect_to crm_domains_url
  	else
  		redirect_to login_url, alert: "Ошибка Email и/или пароля"
  	end
  end

  def destroy
  	session[:user_id] = nil
  	redirect_to login_url, alert: "Сеанс завершен"
  end
end
