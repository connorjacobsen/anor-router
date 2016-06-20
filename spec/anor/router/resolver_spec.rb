require 'spec_helper'

class ExampleAction
  def self.call
  end
end

describe Anor::Router::Resolver do
  describe '#call' do
    let(:resolver) { described_class.new }

    let(:class_method_class) { ExampleAction }

    let(:instance_method_class) do
      Class.new do
        def call
          42
        end
      end
    end

    let(:object) { instance_method_class.new }
    let(:lambda_) { ->() { 42 } }

    context 'when class responds to .call' do
      it 'returns the class as receiver' do
        expect(resolver.call(class_method_class)).to eq(class_method_class)
      end
    end

    context 'when class responds to #call' do
      it 'returns an instance of the class as receiver' do
        expect(resolver.call(instance_method_class)).to(
          be_kind_of(instance_method_class)
        )
      end
    end

    context 'when object responds to #call' do
      it 'returns the object' do
        expect(resolver.call(object)).to eq(object)
      end
    end

    context 'when lambda' do
      it 'returns the lambda' do
        expect(resolver.call(lambda_)).to eq(lambda_)
      end
    end

    context 'when class not found' do
      it 'raises proper exception' do
        expect {
          resolver.call(Fixnum)
        }.to raise_exception(Anor::Router::NotResolveableError)
      end
    end
  end
end
