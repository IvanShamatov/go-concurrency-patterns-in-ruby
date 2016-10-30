require 'bundler'
Bundler.require
require './helper.rb'

# Google Search 2.1
#
# Don't wait for slow servers. No locks. 
# No condition variables. No callbacks.

@web    = FakeWeb.new("web")
@images = FakeWeb.new("image")
@video  = FakeWeb.new("video")


def google(query)
  chan = make_chan()
  go { chan << @web.results(query) }
  go { chan << @images.results(query) }
  go { chan << @video.results(query) }
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
