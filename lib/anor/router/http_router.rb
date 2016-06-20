require 'pry'
require 'anor/router/route_mapper'

module Anor
  module Router
    class HttpRouter
      DEFAULT_SCHEME = 'http'.freeze
      DEFAULT_HOST = 'localhost'.freeze
      DEFAULT_PORT = 8080

      attr_reader :host, :port, :scheme

      def initialize(options = {})
        @host = options.fetch(:host, DEFAULT_HOST)
        @port = options.fetch(:port, DEFAULT_PORT)
        @scheme = options.fetch(:scheme, DEFAULT_SCHEME)

        @mapper = Anor::Router::RouteMapper
        @routes = {}
      end
    end
  end
end
