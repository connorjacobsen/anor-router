$:.push File.expand_path('../../lib', __FILE__)

require 'anor_router'

router = Anor::Router.new do
  root ->(_request) { ['200', {}, ['Hello!']] }
 
  get '/hello', to: ->(request) { ['200', {}, [request.inspect]] }
end

router.run
