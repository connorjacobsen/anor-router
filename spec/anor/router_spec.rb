require 'spec_helper'

describe Anor::Router do
  describe 'integration' do
    it do
      action = ->() { ['200', {}, ['Hello, world']] }
      router = described_class.new do
        get '/users/:id', to: action

        post '/users', to: action

        namespace '/foo' do
          get 'bar', to: action
        end
      end

      expect(router.match(:get, '/users/42')).not_to be_nil
      expect(router.match(:post, '/users')).not_to be_nil
      expect(router.match(:get, '/foo/bar')).not_to be_nil
    end
  end
end
