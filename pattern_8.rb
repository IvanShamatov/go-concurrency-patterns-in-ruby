require 'bundler'
Bundler.require
require './helper.rb'

# Quit channel
#
# We can turn this around and tell Joe to stop 
# when we're tired of listening to him.

def boring(message, quit)
  channel = make_chan()
  go do 
    1.upto(Float::INFINITY) do |i|
      sleep rand(1..1000)/1000.0
      Concurrent::Channel.select do |s|
        s.take(quit) { puts "quit"; exit }
        s.default { channel << "#{message} #{i}" }
      end
    end
  end
  channel
end


def main
  quit_chan = make_chan()
  chan = boring("Ann", quit_chan)
  5.times do 
    puts ~chan
  end
  quit_chan << 0
end

main
