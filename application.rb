app_files = File.expand_path('../app/**/*.rb', __FILE__)
Dir.glob(app_files).each { |file| require file }

# Quero separar a importação dos middleware dos outros arquivos ruby
mid_files  = File.expand_path('../middlewares/*middleware.rb', __FILE__)
Dir.glob(mid_files).each { |file| require_relative file }

class Application
  def call(env)
    request = Rack::Request.new(env)

    middlewares = middles(request)
    middlewares.reduce do |acc, mid|
      mid.new.call(acc)
    end
  end

  private

  MIDDLEWARES = [TestMiddleware, CoisaMiddleware]

  def middles(req)
    [serve_request(req)] + MIDDLEWARES
  end

  def serve_request(request)
    Router.new(request).route!
  end
end
