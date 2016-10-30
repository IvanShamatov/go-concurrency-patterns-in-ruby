require 'bundler'
Bundler.require

def boring(message)
  1.upto Float::INFINITY do |i|
    puts "#{message} #{i}"
    sleep rand(1..1000)/1000.0
  end
end
