$:.push File.expand_path('../../lib', __FILE__)

require 'anor_router'

router = Anor::Router.new do
  root ->(env) { ['200', {}, ['Hello!']] }
 
  get '/hello', to: ->(env) { ['200', {}, [env.inspect]] }
end

router.run
