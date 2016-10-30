require 'bundler'
Bundler.require
require './helper.rb'

# Receive on quit channel
#
# How do we know it's finished? 
# Wait for it to tell us it's done: receive on the quit channel

def boring(message, quit)
  channel = make_chan()
  go do 
    1.upto(Float::INFINITY) do |i|
      sleep rand(1..1000)/1000.0
      Concurrent::Channel.select do |s|
        s.take(quit) do |msg|
          cleanup()
          quit << "See ya!"
        end 
        s.default { channel << "#{message} #{i}" }
      end
    end
  end
  channel
end

def cleanup; end

def main
  quit_chan = make_chan()
  chan = boring("Joe", quit_chan)
  5.times do 
    puts ~chan
  end
  quit_chan << "Bye"
  puts "Joe says #{~quit_chan}"
end

main
