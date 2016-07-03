require 'spec_helper'

describe Anor::Routing::Route do
  let(:regex) { %r{/users/(?<id>[a-zA-Z0-9_]+)} }
  let(:endpoint) do
    Class.new do
      def call
        42
      end
    end
  end

  describe '#initialize' do
    it 'sets attributes correctly' do
      route = described_class.new(regex, to: endpoint, as: :my_endpoint)

      expect(route.regex).to eq(regex)
      expect(route.to).to eq(endpoint)
      expect(route.as).to eq(:my_endpoint)
    end

    it 'requires the :to option' do
      expect {
        described_class.new(regex)
      }.to raise_exception(KeyError)
    end

    it 'does not set a default :as' do
      route = described_class.new(regex, to: endpoint)

      expect(route.as).to be_nil
    end
  end

  describe '#match?' do
    let(:route) { described_class.new(regex, to: endpoint) }

    it 'returns true when match' do
      expect(route.match?('/users/42'))
    end

    it 'returns false when no match' do
      expect(route.match?('/foo/bar')).to be(false)
    end
  end

  describe '#params' do
    it 'sets params after a match' do
      route = described_class.new(regex, to: endpoint, as: :my_endpoint)
      route.match?('/users/12')

      expect(route.params).to eq({ id: '12' })
    end

    it 'has no params without a match' do
      route = described_class.new(regex, to: endpoint, as: :my_endpoint)
      route.match?('/humans/12')

      expect(route.params).to be_nil
    end
  end
end
