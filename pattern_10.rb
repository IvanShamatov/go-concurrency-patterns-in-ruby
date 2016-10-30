require 'bundler'
Bundler.require
require './helper.rb'

# Daisy-chain

def wire(left, right)
  go do 
    get = ~right
    left << 1 + get
  end 
end

def main
  arr = [make_chan()]
  500.times do
    right = make_chan()
    wire(arr.last, right)
    arr << right
  end
  go do
    arr.last << 1
  end  
  puts ~arr.first
end

main
