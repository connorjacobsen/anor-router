module Anor
  module Routing
    module RouteMapper
      VARIABLE_REGEX = '[a-zA-Z0-9_]+'.freeze

      def self.call(path)
        %r{^#{transform(path)}$}
      end

      def self.transform(path)
        chunks = path.split('/').map do |chunk|
          if chunk.start_with?(':')
            chunk.delete!(':')
            "(?<#{chunk}>#{VARIABLE_REGEX})"
          else
            chunk
          end
        end

        chunks.join('/')
      end
    end
  end
end
