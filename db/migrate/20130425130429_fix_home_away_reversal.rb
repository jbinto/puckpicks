class FixHomeAwayReversal < ActiveRecord::Migration
  def up
    # note: This was a one-time migration, and the seeds have since been fixed.
    # Don't run this.
    return

    Game.all.each do |game|
      old_home = game.home
      old_away = game.away

      game.home = old_away
      game.away = old_home

      if game.finished?
        old_home_score = game.home_score
        old_away_score = game.away_score

        game.home_score = old_away_score
        game.away_score = old_home_score
      end

      game.save!

    end
  end

  def down
  end
end
