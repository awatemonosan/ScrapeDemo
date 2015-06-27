require 'nokogiri'

def parseRaw(event, uri, raw)
  doc = Nokogiri::HTML(raw)

  D.trigger('docParsed', uri, doc)
end

# Whenever raw has been fetched, parse it.
D.register('rawFetched',method(:parseRaw))
