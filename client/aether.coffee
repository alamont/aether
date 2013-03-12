Meteor.autorun ->
  Meteor.subscribe "magiccards"

Meteor.startup ->
  Template.battlefield.cards = ->
    MagicCard.find()

  Template.card.rendered = ->
    $(@firstNode).draggable
      start: =>
        $(@firstNode).css('zIndex', 9999);
      stop: =>
        $(@firstNode).css('zIndex', "auto");