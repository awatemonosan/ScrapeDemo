require 'net/http'
require 'uri'

def fetchRaw(event, uri)
  uri = URI(uri)
  raw = Net::HTTP.get(uri)

  D.trigger('rawFetched', uri, raw)
end

# Whenever requested, fetch.
D.register('requestFetch',method(:fetchRaw))
