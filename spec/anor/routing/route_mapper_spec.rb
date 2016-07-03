require 'spec_helper'

describe Anor::Routing::RouteMapper do
  def var_path(var)
    "(?<#{var}>#{described_class::VARIABLE_REGEX})"
  end

  describe '.call' do
    context 'static route' do
      it 'returns appropriate regex for path' do
        route = '/hello'
        regex = described_class.call(route)

        expect(regex).to eq(%r{^/hello$})
        expect(regex.match(route)).not_to be_nil
      end
    end

    context 'dynamic route' do
      it 'returns appropriate regex for the path' do
        route = '/users/:id'
        regex = described_class.call(route)

        expect(regex).to eq(%r{^/users/(?<id>[a-zA-Z0-9_]+)$})
        expect(regex.match('/users/12')).not_to be_nil
        expect(regex.match('/users/connor')).not_to be_nil
      end
    end
  end

  describe '.transform' do
    context 'static route' do
      it 'returns correct path' do
        path = '/hello'

        expect(described_class.transform(path)).to eq('/hello')
      end

      it 'handles / correctly' do
        path = '/'

        expect(described_class.transform(path)).to eq('/')
      end
    end

    context 'with one variable' do
      it 'returns correct path' do
        path = '/users/:id'
        expected_path = "/users/#{var_path('id')}"

        expect(described_class.transform(path)).to eq(expected_path)
      end
    end

    context 'with many variables' do
      it 'returns correct path' do
        path = '/:controller/:action'
        expected_path = "/#{var_path('controller')}/#{var_path('action')}"

        expect(described_class.transform(path)).to eq(expected_path)
      end
    end
  end
end
