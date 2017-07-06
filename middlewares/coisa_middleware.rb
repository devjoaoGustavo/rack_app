class CoisaMiddleware
  def call(req)
    req.tap do |r|
      r[1].merge!({ 'x-Coisa' => 'Eta mundo bão' })
    end
  end
end
