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
* Ability to bet on today's games through the Rails interface (in progress)

### Not completed, in priority order

* Ability to enter game results manually through the web interface
* Automated game result updating through ESPN API, scraping NHL.com or similar
* User's scores (will be calculated on the fly for now)
* Leaderboards

### Lessons learned

* You need to be very cognizant of time zones in Rails. It seems best practice to always use methods on `Time.zone` (e.g. `now`, `today`, `parse`) rather than on the Rails built-in methods. 
* `FactoryGirl.build` is faster than `FactoryGirl.create`, and unit tests *shouldn't* touch the database, but in some cases that can't be avoided. Case in point: testing uniqueness validations. Maybe there's a better, purer, more OO way, but this seems a good balance of pragmatism and speed.
* I find myself hamstrung when working with Bootstrap. I'm no CSS expert, but I can't seem to do the simplest things in Bootstrap.