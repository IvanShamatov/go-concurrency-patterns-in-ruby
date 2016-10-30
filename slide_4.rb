require 'bundler'
Bundler.require

# Using channels
# A channel connects the main and boring 
# goroutines so they can communicate


def boring(message, channel)
  1.upto Float::INFINITY do |i|
    channel << "#{message} #{i}"
    sleep rand(1..1000)/1000.0
  end
end

def main
  chan = Concurrent::Channel.new
  Concurrent::Channel.go { boring('boring!', chan) }

  5.times do 
    puts "You say: #{~chan}"
  end

  puts "You are boring, I'm leaving."
end

main
