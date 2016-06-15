# Anor::Router

Simple HTTP router for Ruby applications.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'anor-router'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install anor-router

## Usage

Router configuration is intended to be familiar to Rails developers.

```ruby
require 'anor-router'

router = Anor::Router.new do
  get '/hello', to: SayHello
  get '/dashboard', to: Dashboard::Index.new
  get '/rack', to: MyRackApp

  redirect '/foo', to: '/bar'

  namespace 'admin' do
    get '/users', to: Admin::Users::Index
  end
end
```

We can also pass in some configuration options:

```ruby
require 'anor-router'

router = Anor::Router.new(scheme: 'https', host: 'myhost.com', port: 5000) do
  get '/login', to: MyApp::Login, as: :login
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake false` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/anor-router.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

