class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def not_authenticated
    redirect_to login_url, :alert => "Please log in."
  end

  def require_admin
    redirect_to root_path unless current_user && current_user.admin?
  end
end
