require 'bundler'
Bundler.require
require './helper.rb'

# Select
#
# The select statement provides another way to handle multiple channels. 
# It's like a switch, but each case is a communication: 
# - All channels are evaluated. 
# - Selection blocks until one communication can proceed, which then does. 
# - If multiple can proceed, select chooses pseudo-randomly. 
# - A default clause, if present, executes immediately if no channel is ready.

def boring(message)
  channel = make_chan()
  go do 
    1.upto(Float::INFINITY) do |i|
      channel << "#{message} #{i}"
      sleep rand(1..1000)/1000.0
    end
  end
  channel
end

# Fan-in using select
# Rewrite our original fanIn function. Only one goroutine is needed. New:

def fan_in(input1, input2)
  chan = make_chan()
  go do
    loop do
      Concurrent::Channel.select do |s|
        s.take(input1) { |msg| chan << msg }
        s.take(input2) { |msg| chan << msg }
      end
    end 
  end 
  chan
end


def main
  chan = fan_in( boring("Ann"), boring("Joe") )

  10.times do |i|
    puts "#{~chan}"
  end

  puts "You are boring; I'm leaving"
end

main
