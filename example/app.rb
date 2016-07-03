$:.push File.expand_path('../../lib', __FILE__)

require 'anor_router'

router = Anor::Router.new do
  get '/hello', to: ->(env) do
    ['200', {}, [env.inspect]]
  end
end

router.run
