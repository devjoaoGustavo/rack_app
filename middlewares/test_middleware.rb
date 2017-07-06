class TestMiddleware
  def call(req)
    req.tap do |r|
      r[1].merge!({ 'x-Test' => 'To testando' })
    end
  end
end
