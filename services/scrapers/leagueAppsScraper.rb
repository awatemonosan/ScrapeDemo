def scrapeLeagueAppsForLeagues(event, uri, doc)
  data         = {}
  data['id']   = uri.request_uri.split('/')[2];
  data['name'] = doc.css('a#the-logo').text

  D.trigger('leagueUpdated', data)
end
D.register('leagueAppsFound', method(:scrapeLeagueAppsForLeagues))

def scrapeLeagueAppsForTeams(event, uri, doc)
  doc.css('span.team-score a').each do |element|
    data           = {}
    data['id']     = element.attr('href').split('/')[4]
    data['name']   = element.text
    data['league'] = uri.request_uri.split('/')[2];

    D.trigger('teamUpdated', data)
  end
end
D.register('leagueAppsFound', method(:scrapeLeagueAppsForTeams))

def scrapeLeagueAppsForLocations(event, uri, doc)
  doc.css('em.game-meta a').each do |element|
    data         = {}
    data['id']   = element.attr('href').split('/')[2] 
    data['name'] = element.text

    D.trigger('locationUpdated', data)
  end
end
D.register('leagueAppsFound', method(:scrapeLeagueAppsForLocations))

# def scrapeLeagueAppsForPlayers(event, uri, doc)
# end
# D.register('leagueAppsFound', method(:scrapeLeagueAppsForPlayers))

def scrapeLeagueAppsForGames(event, uri, doc)
  doc.css('div.game').each do |element|
    element = element.parent

    data                   = {}
    splitGameURI = element.css('span.game-profile-link a').attr('href').value.split('/')
    data['id']             = splitGameURI[4]
    data['league']         = splitGameURI[2]
    data['date']           = element.css('span.date').text
    data['time']           = element.css('span.time').text
    teamElements = element.css('span.score a')
    winnerElement = element.css('span.score.winner a')
    data['teamAway']       = teamElements[0].attr('href').split('/')[4] 
    data['teamAway_score'] = teamElements[0].css('strong.score').text
    data['teamAway_win']   = teamElements[0] == winnerElement
    data['teamHome']       = teamElements[0].attr('href').split('/')[4] 
    data['teamHome_score'] = teamElements[0].css('strong.score').text
    data['teamHome_win']   = teamElements[0] == winnerElement

    D.trigger('gameUpdated', data)
  end
end
D.register('leagueAppsFound', method(:scrapeLeagueAppsForGames))
