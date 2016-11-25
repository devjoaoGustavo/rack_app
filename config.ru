load 'my_rack_app.rb'

Rack::Handler::WEBrick.run Proc.new { |env| ['201', { 'Content-Type' => 'text/html' }, Coisa.index] }
