class BaseController
  attr_reader :request
  def initialize(request)
    @params = request.params
    @request = request
  end

  def index
    content = File.open('app/views/welcome.html').readlines.map(&:chomp)
    build_response(content)
  end

  private

  attr_reader :params

  # The content must be an array, because it's the reponse body of our app
  def build_response(content, status: '200')
    [status, { 'Content-Type' => 'text/html; charset=utf-8' }, content]
  end

  def redirect_to(uri)
    ['302', { 'Location' => uri }, []]
  end
end
