Meteor.publish "magiccardsource", ->
  MagicCardSource.find()

Meteor.publish "games", ->
  Game.find()

Meteor.publish "gamecards", ->
  GameCard.find()
