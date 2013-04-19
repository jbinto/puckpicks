class My::PicksController < ApplicationController
  before_filter :require_login

  def create
    p = current_user.picks.build
    p.game = Game.find(params[:pick][:game_id])
    p.team = Team.find(params[:pick][:team_id])
    p.spread_wager = params[:pick][:spread_wager]

    if p.save
      redirect_to root_url, notice: "You've picked #{p.team.code} +#{p.spread_wager} for game #{p.game.friendly_text}. Good luck!"
    else
      redirect_to root_url, alert: "Something went wrong with your pick (#{p.errors.full_messages}). Try again."
    end
  end

  def index
    
  end
end