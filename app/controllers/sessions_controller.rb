class SessionsController < ApplicationController


  def new

  end

  def create
    user = User.find_by_credentials(params[:user][:name], params[:user][:password])
    if user
      log_in(user)
      redirect_to user_goals_url(user)
    else
      flash[:errors] += ["Wrong credentials!!!!!!"]
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end
end
