require 'spec_helper'

describe Anor::Router::HttpRouter do
  describe '#initialize' do
    it 'sets configuration options' do
      options = {
        port: 8000,
        host: 'localhost',
        scheme: 'https',
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
end
