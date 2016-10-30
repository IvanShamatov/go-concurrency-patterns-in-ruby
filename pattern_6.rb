require 'bundler'
Bundler.require
require './helper.rb'
# Timeout using select

# The time.After function returns a channel that blocks for the specified duration. 
# After the interval, the channel delivers the current time, once.

def boring(message)
  channel = make_chan()
  go do 
    1.upto(Float::INFINITY) do |i|
      sleep_time = rand(1..1000)/1000.0
      channel << "#{message} #{i}: #{sleep_time}"
      sleep sleep_time
    end
  end
  channel
end


def main
  chan = boring("Ann")
  loop do 
    Concurrent::Channel.select do |s|
      s.take(chan) { |msg| puts msg }
      s.take(after(0.9)) { puts "You are to slow"; exit}
    end
  end
end

main
