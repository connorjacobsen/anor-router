require 'anor/routing/route'
require 'anor/routing/route_mapper'

module Anor
  module Routing
    class HttpRouter
      DEFAULT_SCHEME = 'http'.freeze
      DEFAULT_HOST = 'localhost'.freeze
      DEFAULT_PORT = 8080

      attr_reader :host, :port, :scheme, :routes

      def initialize(options = {})
        @host = options.fetch(:host, DEFAULT_HOST)
        @port = options.fetch(:port, DEFAULT_PORT)
        @scheme = options.fetch(:scheme, DEFAULT_SCHEME)

        @routes = Hash.new([])
      end

      def match(action, url)
        @routes[action].detect { |r| r.match?(url) }
      end

      def get(url, options = {})
        register(:get, url, options)
      end

      def post(url, options = {})
        register(:post, url, options)
      end

      def patch(url, options = {})
        register(:patch, url, options)
      end

      def put(url, options = {})
        register(:put, url, options)
      end

      def delete(url, options = {})
        register(:delete, url, options)
      end

      private

      def register(verb, url, options = {})
        route = Route.new(RouteMapper.call(url), options)
        @routes[verb].push(route)
      end
    end
  end
end
