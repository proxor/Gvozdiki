class AdminController < ApplicationController
  before_filter :authorize, :except => :login
  layout 'store'
  
  def login
    session[:user_id] = nil
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to(:controller => :orders, :action => "index")
      else
        flash.now[:notice] = "Неверный логин, пароль или вообще всё неверно."
      end
    end
  end

  def logout
    session[:user_id] = nil
    flash.now[:notice] = "Вы вышли из режима администрирования."
    redirect_to(:action => "index")
  end

  def index
  end

end
