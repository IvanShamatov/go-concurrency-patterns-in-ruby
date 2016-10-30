require 'bundler'
Bundler.require
require "./helper.rb"
# Generator: function that returns a channel
#
# Channels are first-class values, just like strings or integers.

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


def main
  chan = boring('boring!')
  5.times do |i|
    puts "You say: #{~chan}"
  end

  puts "You are boring; I'm leaving"
end

main
