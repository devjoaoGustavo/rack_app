module Coisa
  extend self

  def index
    File.open('index.html').readlines.map(&:chomp)
  end
end
