#TODO:
# [ ] Refactor out @idToEvent:
#       There should be a way to do this in a performant way without requiring this
#       ugly join table solution. 
#       Everything functions. This optimization is not in scope for mvp.

class Dispatcher
  def initialize()
    # uniqueId is incremented every time a new event is registered
    @uniqueId       = 0
    # events:
    # -keys are the names of the events.
    # -values are hashes that match ids to callbacks 
    @events         = {}
    # idToEvent_Join:
    #    have a way to tie the id back to the event/callback that it references
    # -keys are event ids
    # -values are the names of the events they id is a member of
    @idToEvent_Join = {}
  end

  def register(event, callback)
    # If event bucket doesn't exist
    if(not @events.has_key?(event)) then
      # Initialize the event bucket
      @events[event] = {}
    end

    # create a join so we can unregister it later
    @idToEvent_Join[@uniqueId] =  event
    # store the callback
    @events[event][@uniqueId] = callback

    # Increment uniqueId for the next register call
    @uniqueId = @uniqueId + 1

    # Return the ID so it can be referenced later when unregistering
    return @uniqueId - 1
  end

  def unregister(eventId)
    # Check if join table has that eventId
    if(not @idToEvent_Join[eventId].nil?) then
      # store the event...
      event = @idToEvent_Join[eventId]
      # ...and remove the eventId element from it
      @events[event].delete(eventId)
      # now remove the join
      @idToEvent_Join.delete(eventId)
      # return true because the removal was successful
      return true
    end
    # return false because the eventId was not in the join table
    return false
  end

  def trigger(event, *args)
    # Get all of the 'all' callbacks
    all = {}
    if(@events.has_key?('all'))then
      all = @events['all']
    end

    # Get all of the specified callbacks
    target = {}
    if(@events.has_key?(event))then
      target = @events[event]
    end

    # Create combined hash of the two lists
    allEvents = all.merge(target)

    # For each of the evens in the list...
    allEvents.each do |keypair|
      # ...unpack the keypair...
      # key    = keypair[0]
      callback = keypair[1]
      # ...and call the callback with the provided arguments
      callback.call(event, *args)
    end
  end
end

################################################################################
# prototypes for future features
class DispatcherHost
  def initialize(dispatcher, *args)
  end
end

class DispatcherBridge
  def initialize(dest, *args)
  end
end
################################################################################

# The big D
D = Dispatcher.new()