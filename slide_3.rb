require './boring.rb'

# Channels
# A channel in Go provides a connection between two goroutines, 
# allowing them to communicate.
chan = Concurrent::Channel.new

# Sending on a channel
Concurrent::Channel.go { chan << 1 }

# Receiving from a channel
puts ~chan
