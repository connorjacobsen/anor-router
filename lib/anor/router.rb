require 'anor/router/version'

require 'anor/routing/http_router.rb'
require 'anor/routing/resolver'
require 'anor/routing/route'

module Anor
  class Router
    def initialize(options = {}, &block)
      @router = Anor::Routing::HttpRouter.new(options)

      instance_eval(&block)
    end

    # Rack entry point.
    def call(env)
    end

    def get(url, options = {})
      @router.get(url, options)
    end

    def post(url, options = {})
      @router.post(url, options)
    end

    def patch(url, options = {})
      @router.patch(url, options)
    end

    def put(url, options = {})
      @router.put(url, options)
    end

    def delete(url, options = {})
      @router.delete(url, options)
    end

    def match(action, url)
      @router.match(action, url)
    end
  end
end
