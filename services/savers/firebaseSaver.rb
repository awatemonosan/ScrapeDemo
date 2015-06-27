require 'firebase'
$firebase = Firebase::Client.new(Firebase_uri)

def saveRawToFirebase(event, uri, raw)
  fbObj = $firebase.update("Raw/#{uri.request_uri}", raw)
  D.trigger('rawSaved', fbObj)
end

D.register('rawFetched', method(:saveRawToFirebase))

def saveLeagueToFirebase(event, data)
  fbObj = $firebase.update("Leagues/#{data['id']}", data)
  D.trigger('leagueSaved', fbObj)
end

def saveTeamToFirebase(event, data)
  fbObj = $firebase.update("Team/#{data['id']}", data)
  D.trigger('teamSaved', fbObj)
end

def saveLocationToFirebase(event, data)
  fbObj = $firebase.update("Location/#{data['id']}", data)
  D.trigger('locationSaved', fbObj)
end

def savePlayerToFirebase(event, data)
  fbObj = $firebase.update("Player/#{data['id']}", data)
  D.trigger('playerSaved', fbObj)
end

def saveGameToFirebase(event, data)
  fbObj = $firebase.update("Game/#{data['id']}", data)
  D.trigger('gameSaved', fbObj)
end

D.register('leagueUpdated', method(:saveLeagueToFirebase))
D.register('teamUpdated', method(:saveTeamToFirebase))
D.register('locationUpdated', method(:saveLocationToFirebase))
D.register('playerUpdated', method(:savePlayerToFirebase))
D.register('gameUpdated', method(:saveGameToFirebase))
