require 'bundler'
Bundler.require
require './helper.rb'
# Timeout for whole conversation using select

# Create the timer once, outside the loop, to time out the entire conversation. 
# (In the previous program, we had a timeout for each message.)

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
  timeout = after(3)
  loop do 
    Concurrent::Channel.select do |s|
      s.take(chan) { |msg| puts msg }
      s.take(timeout) { puts "You talk too much"; exit}
    end
  end
end

main
