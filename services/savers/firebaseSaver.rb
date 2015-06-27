require 'firebase'
require 'digest/sha1'
$firebase = Firebase::Client.new(Firebase_uri)

# def saveRawToFirebase(event, uri, raw)
#   puts "Raw/#{Digest::SHA1.hexdigest uri.request_uri}"
#   fbObj = $firebase.update("Raw/#{Digest::SHA1.hexdigest uri.request_uri}", raw)
#   D.trigger('rawSaved', fbObj)
# end
# D.register('rawFetched', method(:saveRawToFirebase))

def saveLeagueToFirebase(event, data)
  fbObj = $firebase.update("Leagues/#{data['id']}", data)
  D.trigger('leagueSaved', fbObj)
end
D.register('leagueUpdated', method(:saveLeagueToFirebase))

def saveTeamToFirebase(event, data)
  fbObj = $firebase.update("Teams/#{data['id']}", data)
  D.trigger('teamSaved', fbObj)
end
D.register('teamUpdated', method(:saveTeamToFirebase))

def saveLocationToFirebase(event, data)
  fbObj = $firebase.update("Locations/#{data['id']}", data)
  D.trigger('locationSaved', fbObj)
end
D.register('locationUpdated', method(:saveLocationToFirebase))

def savePlayerToFirebase(event, data)
  fbObj = $firebase.update("Players/#{data['id']}", data)
  D.trigger('playerSaved', fbObj)
end
D.register('playerUpdated', method(:savePlayerToFirebase))

def saveGameToFirebase(event, data)
  fbObj = $firebase.update("Games/#{data['id']}", data)
  D.trigger('gameSaved', fbObj)
end
D.register('gameUpdated', method(:saveGameToFirebase))
