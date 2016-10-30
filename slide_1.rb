require './boring.rb'
# Ignoring it
#
# The go statement runs the function as usual, but doesn't make the caller wait.
# It launches a goroutine.
# The functionality is analogous to the & on the end of a shell command.

Concurrent::Channel.go do 
  boring("Hah")
end
