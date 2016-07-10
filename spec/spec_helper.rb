$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))

require 'anor-router'

require 'rubygems'
require 'bundler'
Bundler.setup :default, :test

# Require support files.

# Require third party dependencies.
require 'pry'
require 'rack/test'

RSpec.configure do |config|
  config.include Rack::Test::Methods
end
