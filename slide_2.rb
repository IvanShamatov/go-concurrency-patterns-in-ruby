require './boring.rb'

# Ignoring it a little less
#
# When main returns, the program exits and takes 
# the boring function down with it.
# We can hang around a little, and on the way show that 
# both main and the launched goroutine are running.

Concurrent::Channel.go { boring("boring") }
puts "I'm listening"
sleep 2
puts "You are boring; I'm leaving"
