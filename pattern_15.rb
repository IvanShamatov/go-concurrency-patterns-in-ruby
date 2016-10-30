require 'bundler'
Bundler.require
require './helper.rb'

# Google Search 3.0
#
# Reduce tail latency using replicated search servers.

@web1    = FakeWeb.new("web")
@web2    = FakeWeb.new("web")
@images1 = FakeWeb.new("image")
@images2 = FakeWeb.new("image")
@video1  = FakeWeb.new("video")
@video2  = FakeWeb.new("video")


def first(query, *replicas)
  chan = make_chan()
  replicas.each do |rep|
    go { chan << rep.results(query) }
  end
  ~chan
end


def google(query)
  chan = make_chan()
  go { chan << first( query, @web1, @web2 ) }
  go { chan << first( query, @images1, @images2 ) }
  go { chan << first( query, @video1, @video2 ) }
  results = []
  timeout = after(0.08)
  3.times do 
    Concurrent::Channel.select do |s|
      s.take(chan) { |msg| results << msg }
      s.take(timeout) { puts "timeout" }
    end
  end
  results
end


def main
  started = Time.now
  results = google("golang")
  elapsed = Time.now-started
  puts results
  puts elapsed
end

main
