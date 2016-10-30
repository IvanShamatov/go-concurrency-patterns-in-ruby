require 'bundler'
Bundler.require
require './helper.rb'

# Restoring sequencing

# Send a channel on a channel, making goroutine wait its turn.
# Receive all messages, then enable them again by sending on a private channel.
# First we define a message type that contains a channel for the reply.
Message = Struct.new(:body, :wait)

def boring(message)
  channel = make_chan()
  wait_channel = make_chan

  go do 
    1.upto(Float::INFINITY) do |i|
      channel << Message.new("#{message} #{i}", wait_channel) 
      sleep rand(1..1000)/1000.0
      ~wait_channel
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
  chan = fan_in( 
    boring("Ann"), 
    boring("Joe") 
  )

  5.times do |i|
    message1 = ~chan; puts message1.body
    message2 = ~chan; puts message2.body
    message1.wait << true
    message2.wait << true
  end

  puts "You are boring; I'm leaving"
end

main
