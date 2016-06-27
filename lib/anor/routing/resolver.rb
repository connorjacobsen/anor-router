module Anor
  module Routing
    # Error signifying the action could not be resolved.
    class NotResolveableError < StandardError; end

    class Resolver
      def call(action)
        if action.kind_of?(Class) && action.respond_to?(:call)
          # Action.call defined
          action
        elsif action.kind_of?(Class) && action.public_method_defined?(:call)
          # Action#call defined
          action.new
        elsif action.respond_to?(:call)
          action
        else
          raise NotResolveableError
        end
      end
    end
  end
end
