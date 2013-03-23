Deps.autorun ->
  Meteor.subscribe "magiccards"
  Meteor.subscribe "games", ->
    Session.set "currentGame", Game.findOne().id
  Meteor.subscribe "gamecards"

Meteor.startup ->

  Session.set "dropTarget", null
  Session.set "dropSource", null

  Template.battlefield.cards = ->
    GameCard.find {game_id: Session.get('currentGame')}

  Template.card.rendered = ->
    $(@firstNode).draggable
      start: =>
        $(@firstNode).css('zIndex', 9999);
      stop: (e,ui) =>
        $(@firstNode).css('zIndex', "auto");
        Session.set "dropSource", @data.card.num
    $(@firstNode).droppable
      drop: (e,ui) =>
        $(@firstNode).removeClass("highlight")
        Session.set "dropTarget", @data.card.num
      over: (e,ui) =>
        $(@firstNode).addClass("highlight")
      out: (e,ui) =>
        $(@firstNode).removeClass("highlight")

Deps.autorun ->
  if Session.get("dropTarget") != null && Session.get("dropSource") != null
    console.log GameCard.findOne {num: Session.get "dropSource"}
    console.log GameCard.findOne {num: Session.get "dropTarget"}
    Session.set "dropTarget", null
    Session.set "dropSource", null