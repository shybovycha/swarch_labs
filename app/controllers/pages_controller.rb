class PagesController < ApplicationController
  def home
  end

  def login
    if u = User.authenticate(params[:email], params[:password]) then
      session[:email] = params[:email]
      session[:password] = params[:password]
      redirect_to "/users/#{ u.id }"
    else
      flash[:error] = "Could not log in"
      redirect_to :back 
    end
  end

  def logout
    session[:email], session[:password] = nil, nil
    redirect_to :back
  end
end
