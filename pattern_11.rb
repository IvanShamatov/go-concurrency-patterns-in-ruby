require 'bundler'
Bundler.require
require './helper.rb'

# Google Search: A fake framework
#
# We can simulate the search function, 
# much as we simulated conversation before.

class FakeWeb
  attr_accessor :kind

  def initialize(kind)
    @kind = kind
  end
  
  def results(query)
    sleep rand(1..100)/1000.0
    "#{kind} result for #{query}"
  end
end

def main
  google = FakeWeb.new("google")
  started = Time.now
  results = google.results("golang")
  elapsed = Time.now-started
  puts results
  puts elapsed
end

main
