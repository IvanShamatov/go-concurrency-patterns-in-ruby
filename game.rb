require 'bundler'
Bundler.require
require './helper.rb'

Ball = Struct.new(:hits)

def player(name, table)
  loop do
    ball = ~table 
    ball.hits += 1
    puts "#{name}: #{ball.hits}"
    sleep(rand(0.1..0.3))
    table << ball
  end
end

def main
  table = make_chan
  go { player("Ping", table) }
  go { player("Pong", table) }
  table << Ball.new(0)
  sleep 3
  ~table
end

main
