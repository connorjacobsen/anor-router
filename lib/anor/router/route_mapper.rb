module Anor
  module Router
    module RouteMapper
      VARIABLE_REGEX = '[a-zA-Z0-9_]+'.freeze

      def self.call(path)
        %r(^#{transform(path)}$)
      end

      private

      def self.transform(path)
        chunks = path.split('/').map do |chunk|
          if chunk.start_with?(':')
            chunk.gsub!(':', '')
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
