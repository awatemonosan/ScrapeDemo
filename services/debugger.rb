def printEvent(event, *args)
  puts("Event Triggered: '#{event}'")
end

# whenever anything happens, puts it.
D.register("all",method(:printEvent))
