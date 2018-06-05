require_relative 'base_controller.rb'

class DogsController < BaseController
  def index
    build_response(content, status: 200)
  end

  private

  def content
    File.open('app/views/index.html').readlines
  end
end
