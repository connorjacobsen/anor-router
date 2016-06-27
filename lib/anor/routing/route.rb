module Anor
  module Routing
    class Route
      attr_reader :regex, :to, :as

      def initialize(regex, options = {})
        @regex = regex
        @to = options.fetch(:to) { raise KeyError, ':to param required' }
        @as = options.fetch(:as, nil)
      end

      def match?(url)
        !!regex.match(url)
      end
    end
  end
end
