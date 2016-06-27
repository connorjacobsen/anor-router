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

      def get(url, options = {})
        route = Route.new(RouteMapper.call(url), options)
        @routes[:get].push(route)
      end

      def match(action, url)
        @routes[action].detect { |r| r.match?(url) }
      end
    end
  end
end
