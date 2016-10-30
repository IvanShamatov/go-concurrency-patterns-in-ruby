require 'bundler'
Bundler.require
require './helper.rb'

# Multiplexing
#
# These programs make Joe and Ann count in lockstep. 
# We can instead use a fan-in function to let whosoever is ready talk.

def boring(message)
  channel = make_chan
  go do 
    1.upto(Float::INFINITY) do |i|
      channel << "#{message} #{i}"
      sleep rand(1..1000)/1000.0
    end
  end
  channel
end


def fan_in(input1, input2)
  chan = make_chan()
  go { loop { chan << ~input1} }
  go { loop { chan << ~input2} }
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
