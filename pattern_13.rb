require 'bundler'
Bundler.require
require './helper.rb'

# Google Search 2.0
#
# Run the Web, Image, and Video searches concurrently, and wait for all results.
# No locks. No condition variables. No callbacks.

@web    = FakeWeb.new("web")
@images = FakeWeb.new("image")
@video  = FakeWeb.new("video")

def google(query)
  chan = make_chan()
  go { chan << @web.results(query) }
  go { chan << @images.results(query) }
  go { chan << @video.results(query) }
  results = []
  3.times do 
    results << ~chan
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
