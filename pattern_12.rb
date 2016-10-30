require 'bundler'
Bundler.require
require './helper.rb'

# Google Search 1.0
#
# The Google function takes a query and returns a slice of Results (which are just strings).
# Google invokes Web, Image, and Video searches serially,
# appending them to the results slice.

def google(query)
  web     = FakeWeb.new("web")
  results = web.results(query)
  images  = FakeWeb.new("image")
  results << images.results(query)
  video   = FakeWeb.new("video")
  results << video.results(query)
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
