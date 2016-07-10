require 'rack'

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

      %i(get post patch put delete).each do |method|
        define_method(method) do |url, options = {}|
          register(method, url, options)
        end
      end

      def redirect(url, options = {})
        status = options.fetch(:status, 302)
        unless status >= 300 && status < 400
          raise ArgumentError, 'Status must be 3xx'
        end

        action = ->(env) do
          response = ::Rack::Response.new(env)
          response.redirect(eval(%|"#{url}"|), status)
          response.finish
        end

        register(:get, path, options.merge!(to: action))
      end

      private

      def register(verb, url, options = {})
        route = Route.new(RouteMapper.call(url), options)
        @routes[verb].push(route)
      end
    end
  end
end
