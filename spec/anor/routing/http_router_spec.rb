require 'spec_helper'

describe Anor::Routing::HttpRouter do
  describe '#initialize' do
    it 'sets configuration options' do
      options = {
        port:   8000,
        host:   'localhost',
        scheme: 'https'
      }

      router = described_class.new(options)

      expect(router.port).to eq(8000)
      expect(router.host).to eq('localhost')
      expect(router.scheme).to eq('https')
    end

    it 'sets defaults when options not given' do
      router = described_class.new

      expect(router.port).to eq(8080)
      expect(router.host).to eq('localhost')
      expect(router.scheme).to eq('http')
    end
  end

  describe '#get' do
    it 'adds a GET route' do
      router = described_class.new

      router.get('/users/:id', to: ->() { ['200', {}, ['Hello, world']] })

      expect(router.routes[:get].size).to eq(1)
      expect(router.routes[:get].first.match?('/users/12'))
    end
  end

  describe '#match' do
    let(:router) { described_class.new }
    let(:action) { ->() { ['200', {}, ['Hello, world']] } }

    it 'correctly matches' do
      router.get('/users/:id', to: action)

      expect(router.match(:get, '/users/12'))
      expect(router.match(:get, '/users/12/photos')).to be_nil
    end

    it 'does not match incorrectly' do
      router.get('/users/:id', to: action)

      expect(router.match(:get, '/humans/12')).to be_nil
    end

    it 'correctly matches' do
      router.get('/users/:id/photos', to: action)

      expect(router.match(:get, '/users/12/photos'))
      expect(router.match(:get, '/users/12')).to be_nil
      expect(router.match(:get, '/users/')).to be_nil
    end
  end
end
