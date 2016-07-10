module Anor
  module Routing
    class Namespace
      attr_reader :router, :name

      def initialize(router, name, &block)
        @router = router
        @name = name

        instance_eval(&block) if block_given?
      end

      %i(get post patch put delete).each do |verb|
        define_method(verb) do |url, options = {}|
          @router.public_send(verb, path_for(url), options)
        end
      end

      def namespace(name, &blk)
        Routing::Namespace.new(self, name, &blk)
      end

      private

      def path_for(url)
        [@name, url].join('/')
      end
    end
  end
end
