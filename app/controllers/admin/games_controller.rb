class Admin::GamesController < ApplicationController
  
  before_filter :require_login, :require_admin

  def index
    @games = Game.past_week.order("faceoff_time DESC")
  end

  def edit
  end

end