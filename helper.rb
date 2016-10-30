def go(&block)
  Concurrent::Channel.go do 
    yield
  end
end

def make_chan
  Concurrent::Channel.new
end

def after(time)
  Concurrent::Channel.after(time)
end


class FakeWeb
  attr_accessor :kind

  def initialize(kind)
    @kind = kind
  end
  
  def results(query)
    time_to_sleep = rand(1..100)/1000.0
    sleep time_to_sleep
    "#{kind} result for #{query}. Took: #{time_to_sleep}"
  end
end
