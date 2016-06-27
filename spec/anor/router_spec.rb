require 'spec_helper'

describe Anor::Router do
  describe 'integration' do
    it do
      action = ->() { ['200', {}, ['Hello, world']] }
      router = described_class.new do
        get '/users/:id', to: action

        post '/users', to: action
      end

      expect(router.match(:get, '/users/42'))
    end
  end
end
