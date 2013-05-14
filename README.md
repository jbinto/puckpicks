# PuckPicks

*"Proline for bragging rights"*

PuckPicks is a web-based NHL hockey prediction game, written as a Rails learning-project by [Jesse Buchanan](http://jbinto.ca). It is currently *LIVE* at http://puckpicks.ca/

## Current rules

* For any game, users can pick a team they think will win, and the minimum amount they will win by.
 * For example: TOR +1 means you think Toronto will win by 1 or more point. BOS +2 means you think Boston will win by 2 or more points.
* Users can bet on as many, or as few games as they wish in a single day.
* To keep things simple, there are no odds or wagering (or more precisely, these are fixed):
 * If you wager a team will win by 1 or more, you are risking 1 point. 
 * If you wager a team will win by 2 or more, you are risking 2 points. 
* Part of the game design is to avoid incentivizing those who play more often than others.
 * You start at 0, and your score can go negative. 
 * If you bet recklessly, you are likely to lose points. If you bet carefully, you are likely to gain points.
 * Leaderboards currently show all-time score, but the plan is to introduce daily and weekly leaderboards, to incentivize playing in the short term.

## Current status

This is pre-alpha software. Not all of the rules are implemented yet.

### Completed features

* Import 2012-13 NHL schedule from a static text file
* Create Rails models for Pick and Game, with some decent, well-tested validations & sanity checks
* Grading/deciding of picks based on a game's result
* User sign up and authentication with Sorcery
* Ability to bet on today's games through the Rails interface
* Don't let user bet on the same game twice
* Ability to enter game results manually through the web interface
* User's scores (will be calculated on the fly for now)
* Migrate CSS/Bootstrap of the picks page to Foundation
* Automated game result updating through ESPN API, scraping NHL.com or similar
* All-time leaderboards

### Not completed, in priority order

* Allow user to withdraw their bet (until game starts)
* On picks page, split into groups: picked, open, closed
* AJAXify the admin score updater
* AJAXify the picks page
* Calendar-style navigation: allow user to click "next day"
* Show more than one day
* JSON API to allow users to automate their picks

### Lessons learned

* You need to be very cognizant of time zones in Rails. 
 * Everything in your Rails database is always stored in UTC.
 * You have to define the *application's* time zone in `application.rb`, e.g. `config.time_zone = 'America/Toronto'`
 * You also have to define the *system's* time zone. On Heroku, this can be done with `heroku config:add TZ="America/Toronto"`.
 * PuckPicks is designed to run on Eastern Standard Time. To get automatic/transparent time zone conversion, it is best practice to always use the Rails `Time.zone` methods (e.g. `now`, `today`, `parse`) rather than the equivalents on the Ruby built-in `Date`, `Time`, and `DateTime` classes. 
 * Inconsistencies between the application timezone and the system timezone will cause significant grief. I spent a few hours chasing down a sorting bug, where 9PM and 10PM games were listed *before* 7PM and 8PM games. Even though the display time was correct, the ordering on database queries was still using UTC. The sorting only considered the time portion (not the date), so the later games "came before" the earlier games.

* Model tests in Rails aren't always pure unit tests.
 * `FactoryGirl.build` is faster than `FactoryGirl.create` since there's no persistence. `build` is used wherever possible throughout the tests.
 * Unit tests *shouldn't* touch the database, but in some cases that "can't" be avoided, like when testing uniqueness validations. In these tests, `create` is used, since it's necessary to have a record saved in the database before attempting to save a duplicate.
 * There is probably a better, purer, more OO way to test uniqueness validations, but using `create` when necessary and `build` elsewhere is a good balance of pragmatism and speed.

* I don't understand the magic behind ActiveRecord nearly as much as I thought I did. More often than not, the underlying database (Postgres) leaks through. 
 * For instance, adding a `belongs_to :home, :class_name => Team` declaration on `Game` will add a `home` accessor. This will look for a `home_id` column on the `Game` table, and for the associated record on the `Team` table. This lets me ask for `game.home.city`. Unfortunately, this magic doesn't extend to queries: `Game.where(:home => TOR)` just blindly looks for a `game` column without any ActiveRecord smarts.
 * The same thing goes on the uniqueness validations: ActiveRecord doesn't seem to be smart enough to think in terms of `home` and `away`. You have to specify `home_id` or `away_id` explicitly on your uniqueness validation.

* It is very easy to fall in the N+1 query trap. For example, if I were to iterate through my `Game` model, I would incur extra 2 queries *per game* to look up the `home` and `away` teams. If I'm listing 100 games, this means 201 queries! The solution to this is to use eager loading: running `Game.includes(:home, :away).all` will invoke the query against the `games` table first, and then look up only the necessary `teams` using a single `SELECT...IN` query.

* I find myself hamstrung when working with Bootstrap. I'm no CSS expert, but I can't seem to do the simplest things in Bootstrap compared to vanilla CSS. I find myself longing for Visual Basic style UI designers with dead easy snap-to-edge alignments. **UPDATE:** Since this comment was originally written, I've changed to the Foundation CSS framework. Theres's not anything fundamentally different between these two frameworks, but I find Foundation simpler. This is likely because I invested time to teach myself Foundation in isolation of my app, whereas I was working with Bootstrap "hot", following a tweak, check, repeat pattern. In any case, it's important not to forget that *it's all just CSS in the end*.

### Questions to be answered

* My models are really getting big. What's the conventional way to organize them? e.g. order of associations, filters, scopes, helper methods, validations.
* Was it worth creating all of this validation, or am I bringing my old static-language habits into Ruby?
* How do I log warning-level errors? For example, I don't want to raise an exception if you call Pick#decide for an unfinished or already decided game. But I do want to know my code is doing this.
* I need offline docs for Rails for when I'm on the subway. Even when online, grepping official docs is a better strategy than wildly Googling things. Does such a thing exist? **UPDATE:** The `pry` gem is perfect for this.
* On my models, I have a lot of mutator methods that don't save the record. For example, `Pick#decide`, `Game#decide_picks`. Is this conventional? Should I make them bang-methods (`decide!`) and have them save the record? Should they return `true`/`false` in this case or raise exceptions?
* Is the whole Now.now concept a bad idea? Do I *really* need to override the time like this? I'm not even using it for unit testing; I'm using it for manual testing. Could monkey patching be a better idea?
* I have `Game#set_result`. This takes a `:home_score` and an `:away_score`. This seems unnecessary. Can't I just have a `process_result` after_update filter that handles this? **UPDATE:** No, the reason I have the `set_result` method is that the scores are not marked as `attr_accessible`. Using this method bypasses mass assignment protection, but is safe because it is only called from privileged controller actions.
