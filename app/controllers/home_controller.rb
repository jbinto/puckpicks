class HomeController < ApplicationController

  def home
    @today_games = Game.today.order(:id).all
    if logged_in?
      @pick = current_user.picks.build
    end
  end


end
