require 'spec_helper'

describe Anor::Routing::Namespace do
  let(:router) { Anor::Router.new }
  let(:namespace) { described_class.new(router, '/foo') }

  let(:action) do
    ->(params) { ['200', {}, ['Hello, world!']] }
  end

  describe '#initialize' do
  end

  describe '#get' do
    it 'matches correctly' do
      namespace.get('bar', to: action)

      expect(router.match(:get, '/foo/bar')).not_to be_nil
    end
  end

  describe '#post' do
    it 'matches correctly' do
      namespace.post('bar', to: action)

      expect(router.match(:post, '/foo/bar')).not_to be_nil
    end
  end

  describe '#put' do
    it 'matches correctly' do
      namespace.put('bar', to: action)

      expect(router.match(:put, '/foo/bar')).not_to be_nil
    end
  end

  describe '#patch' do
    it 'matches correctly' do
      namespace.patch('bar', to: action)

      expect(router.match(:patch, '/foo/bar')).not_to be_nil
    end
  end

  describe '#delete' do
    it 'matches correctly' do
      namespace.delete('bar', to: action)

      expect(router.match(:delete, '/foo/bar')).not_to be_nil
    end
  end

  describe '#namespace' do
    it 'can nest namespaces' do
      namespace.namespace('bar') do
        get 'baz', to: ->(params) { 42 }
      end

      expect(router.match(:get, '/foo/bar/baz')).not_to be_nil
    end
  end
end
