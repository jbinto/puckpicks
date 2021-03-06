class HomeController < ApplicationController

  def home
    @today_games = Game.includes(:home).includes(:away).today.order(:faceoff_time).all
    @leaders = User.leaders
    if logged_in?
      @pick = current_user.picks.build
      @my_picks = current_user.picks.includes(:game).includes(:team)
    end
  end

end
