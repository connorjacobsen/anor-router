require 'rack'

require 'anor/router/version'
require 'anor/routing/http_router'
require 'anor/routing/request'
require 'anor/routing/resolver'
require 'anor/routing/route'

module Anor
  class Router
    class NotFound < StandardError
      def call(_env)
        ['404', {}, ['404 Not Found']]
      end
    end

    def initialize(options = {}, &block)
      @router = Anor::Routing::HttpRouter.new(options)

      instance_eval(&block)
    end

    # Rack entry point.
    def call(env)
      request = Anor::Routing::Request.new(env)
      app = match(request.method, request.path)

      if app.nil?
        NotFound.new.call(request)
      else
        request.params.merge(app.params)
        app.to.call(request)
      end
    end

    def run
      Rack::Server.start(
        app: self,
        Port: @router.port
      )
    end

    def root(action)
      @router.get('/', to: action)
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

    def namespace(path, &block)
    end

    def match(action, url)
      @router.match(action, url)
    end
  end
end
