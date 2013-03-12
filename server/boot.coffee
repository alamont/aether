Meteor.publish "magiccards", ->
  MagicCard.find({})
