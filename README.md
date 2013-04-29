# PuckPicks

*"Proline for bragging rights"*

PuckPicks is a web-based NHL hockey prediction game, written as a Rails learning-project by [Jesse Buchanan](http://jbinto.ca).

## Proposed rules

* For any game, users can pick a team, and a spread (+1 or +2). 
* In keeping with Proline rules, +2 means "team wins by 2 or more".
* Users can bet on as many, or as few games as they wish.
* To keep things simple, there are no odds or wagering (or more precisely, these are fixed):
 * If you wager a team will win by 1, you are risking 1 point. 
 * If you wager a team will win by 2, you are risking 2 points. 
* Part of the game design is to avoid incentivizing those who bet more often than others.
 * Your score can go negative. 
 * If you bet recklessly, you will lose points. If you bet carefully, you will gain points.
 * Leaderboards will be done for day, week, month. You'll get some sort of congratulations email/badge if you win any of these, so it doesn't have to be a season-long marathon.

## Current status

This is pre-alpha software. Not all of the rules are implemented yet.

### Completed

* Import 2012-13 NHL schedule
* Rails models for Pick and Game, with some decent, well-tested validations & sanity checks
* Grading/deciding of picks based on a game's result
* User sign up and authentication with Sorcery
* Ability to bet on today's games through the Rails interface
* Don't let user bet on a game twice
* Ability to enter game results manually through the web interface
* User's scores (will be calculated on the fly for now)
* Migrate CSS/Bootstrap of the picks page to Foundation

### Not completed, in priority order

* PLAYOFFS!!
* Allow user to withdraw their bet (until game starts)
* Leaderboards

* On picks page, split into groups: picked, open, closed

* AJAXify the admin score updater
* AJAXify the picks page
* Calendar-style navigation: allow user to click "next day"
* Show more than one day
* Automated game result updating through ESPN API, scraping NHL.com or similar
* JSON API to allow users to automate their picks

### Lessons learned

* You need to be very cognizant of time zones in Rails. It seems best practice to always use methods on `Time.zone` (e.g. `now`, `today`, `parse`) rather than on the Ruby built-in methods. I spent a few hours chasing down a bug that had 9PM and 10PM games sorted *before* 7PM and 8PM games (long story short, it boiled down to before or after midnight UTC).

* `FactoryGirl.build` is faster than `FactoryGirl.create`, and unit tests *shouldn't* touch the database, but in some cases that "can't" be avoided. Case in point: testing uniqueness validations. Maybe there's a better, purer, more OO way, but this seems a good balance of pragmatism and speed.

* I find myself hamstrung when working with Bootstrap. I'm no CSS expert, but I can't seem to do the simplest things in Bootstrap compared to vanilla CSS. I find myself longing for Visual Basic style UI designers with dead easy snap-to-edge alignments. 

* I don't understand the magic behind ActiveRecord nearly as much as I thought I did. More often than not, the underlying database (Postgres) leaks through. 
 * For instance, adding a `belongs_to :home, :class_name => Team` declaration on `Game` will allow me to say something like `game.home.city` (given a `home_id` column on the table), but this magic doesn't extend to queries: `Game.where(:home => TOR)` just blindly looks for a `game` column without any ActiveRecord smarts.
 * Same thing goes on the uniqueness validations: ActiveRecord doesn't seem to be smart enough to think in terms of `home` and `away`, rather you have to specify `home_id`.


### Questions to be answered

* My models are really getting big. What's the conventional way to organize them? e.g. order of associations, filters, scopes, helper methods, validations.
* Was it worth creating all of this validation, or am I bringing my old static-language habits into Ruby?
* How do I log warning-level errors? For example, I don't want to raise an exception if you call Pick#decide for an unfinished or already decided game. But I do want to know my code is doing this.
* I need offline docs for Rails for when I'm on the subway. Even when online, grepping official docs is a better strategy than wildly Googling things. Does such a thing exist?
* On my models, I have a lot of mutator methods that don't save the record. For example, `Pick#decide`, `Game#decide_picks`. Is this conventional? Should I make them bang-methods (`decide!`) and have them save the record? Should they return `true`/`false` in this case or raise exceptions?
* Is the whole Now.now concept a bad idea? Do I *really* need to override the time like this? I'm not even using it for unit testing; I'm using it for manual testing. Could monkey patching be a better idea?
* I have `Game#set_result`. This takes a `:home_score` and an `:away_score`. This seems unnecessary. Can't I just have a `process_result` after_update filter that handles this?
