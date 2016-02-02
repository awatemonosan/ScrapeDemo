




def saveHtml(uri, raw, html)



  D.trigger('dataSaved', uri, raw, html)
end

# whenever html has been parsed, save it to the DB
D.register('htmlParsed',method(:saveHtml))
