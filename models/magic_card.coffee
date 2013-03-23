class GameCard extends Minimongoid
  @_collection: new Meteor.Collection 'gamecards'

  attachCard: (card) ->
    unless @attributes['childCards']
      @attributes['childCards'] = []
    @attributes['childCards'].push card.id
