class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user = login(params[:username], params[:password])
    if user
      redirect_back_or_to root_url, :notice => "Welcome back #{user.username}. Get your picks in now!"
    else
      flash[:alert] = "Email or password was invalid. Please try again."
      redirect_to login_path
    end
  end
  
  def destroy
    logout
    redirect_to root_url, :notice => "You have been signed out."
  end
end

