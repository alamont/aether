Meteor.methods
  startGame: ->
    Game.destroyAll()
    GameCard.destroyAll()
    game = Game.create({})
    console.log MagicCardSource.find({},{limit: 10}).fetch()
    _.each MagicCardSource.all({},{limit: 10}), (card) -> 
      console.log {card: card.attributes, game_id: game.id}
      GameCard.create {card: card.attributes, game_id: game.id}