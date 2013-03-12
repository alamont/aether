cheerio = __meteor_bootstrap__.require('cheerio')

Meteor.methods
  scrapeCards: (set="gtc") ->
    result = undefined
    @unblock()
    base_url = "http://magiccards.info"
    result = Meteor.http.get("#{base_url}/#{set}/en.html")
    if result.statusCode is 200
      $ = cheerio.load(result.content)
      table = $("table").eq(3).html()
      cards = $("tr",table).slice( 1, $("tr",table).length-1 ).map (i,el) ->
        num: parseInt $("td", $(el).html()).eq(0).text()
        url: base_url + $("td a", $(el).html()).attr("href")
        name: $("td a", $(el).html()).text()
        set: $("td", $(el).html()).eq(6).text()
        image_url: "http://magiccards.info/scans/en/#{set}/#{parseInt $('td', $(el).html()).eq(0).text()}.jpg"

      for i, card of cards
        MagicCard.create(card)


  scrapeCard: (url) ->
    result = undefined
    @unblock
    result = Meteor.http.get(url)
    if result.statusCode is 200
      $ = cheerio.load(result.content)
      $("#ctl00_ctl00_ctl00_MainContent_SubContent_SubContent_cardImage").attr("src")