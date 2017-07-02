module Coisa
  extend self

  def index
    content
  end

  private

  def content
    File.open('index.html').readlines.map(&:chomp)
  end
end
