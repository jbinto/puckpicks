class Admin::GamesController < ApplicationController
  
  before_filter :require_login, :require_admin

  def index
    @games = Game.past_week.order("faceoff_time DESC")
  end

  def update
    game = Game.find(params[:id])
    game.set_result(params[:game])
    game.save

    redirect_to admin_games_path, :notice => "Game ##{game.id} score set (#{game.boxscore})."
  end

end