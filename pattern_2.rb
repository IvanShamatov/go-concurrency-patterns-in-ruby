require 'bundler'
Bundler.require
require './helper.rb'

# Channels as a handle on a service
#
# Our boring function returns a channel that lets us 
# communicate with the boring service it provides.
# We can have more instances of the service.

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
  ann = boring("Ann")
  joe = boring("Joe")

  5.times do |i|
    puts "#{~joe}"
    puts "#{~ann}"
  end

  puts "You are boring; I'm leaving"
end

main
