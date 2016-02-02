require 'rubygems'

# A custom eventing library, Documentation provided in the file
require 'libs/bigD'

# Configuration file. Change to use your firebase server
require 'config'

# Services
require 'controllers/debugger'
require 'controllers/fetcher'
require 'controllers/parser'
require 'controllers/analyzers/leagueAppsAnalyzer'
require 'controllers/scrapers/leagueAppsScraper'
require 'controllers/savers/firebaseSaver'

#fire off the first fetch request
D.trigger('requestFetch', 'http://superhockeyleague1.leagueapps.com/leagues/56625/schedule')

# It would be best if I built some sort of main loop support for bigD so I could
#   fire off requestFetch every so often or something.