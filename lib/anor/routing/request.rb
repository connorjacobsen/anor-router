require 'rack/request'

module Anor
  module Routing
    class Request < Rack::Request
      def method
        request_method.downcase.to_sym
      end
    end
  end
end
