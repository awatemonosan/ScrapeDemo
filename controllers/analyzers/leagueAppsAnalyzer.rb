def analyzeForLeagueApps(event, uri, doc)
  # TODO: A pretty weak identifier. Figure out a better one.
  if(doc.css('input#lapi-base-url').length>0) then
    D.trigger('leagueAppsFound', uri, doc)
  end
end

# whenever doc has been parsed, analyze it for leagueApps.
D.register('docParsed',method(:analyzeForLeagueApps))
