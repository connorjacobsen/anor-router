module Anor
  module Routing
    class Route
      attr_reader :regex, :to, :as, :params

      def initialize(regex, options = {})
        @regex = regex
        @to = options.fetch(:to) { raise KeyError, ':to param required' }
        @as = options.fetch(:as, nil)
      end

      def match?(url)
        match = regex.match(url)

        unless match.nil?
          @params ||= {}
          match.names.each_with_index do |name, index|
            @params[name.to_sym] = match.captures[index]
          end
        end

        !match.nil?
      end
    end
  end
end
