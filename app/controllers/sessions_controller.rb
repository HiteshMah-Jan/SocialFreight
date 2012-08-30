class SessionsController < ApplicationController

  layout 'guest'

  def new
  end

  def create
    user = login(params[:email], params[:password], params[:remember_me])
    if user
      session[:patron_id] = user.patron_id if user.patron_id
      if params[:remember_me]
        session[:socialfreight_mail] = params[:email]
      else
        session[:socialfreight_mail] = nil
      end
      redirect_back_or_to root_url
    else
      flash.now.alert = "Email or password is invalid"
      render :new#, :notice => "Email or password is invalid"
    end
  end
  
  def destroy
    usermail = session[:socialfreight_mail] if session[:socialfreight_mail]
    logout
    session[:socialfreight_mail] = usermail.to_s

    redirect_to root_url, :notice => "Bye bye happiness..."
  end

end
