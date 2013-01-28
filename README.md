# Primo

A better, configurable, default (prime) Rails stack.

Inspired by Steve Klabnik's article ["Rails has Two Default Stacks"](http://words.steveklabnik.com/rails-has-two-default-stacks)

## Why is this useful?

Rails Templates are awesome, especially for hackers that often need to set up the same basic app. Sadly there is currently no sharing between application templates and Primo tries to make this easier.

By default Primo allows you to run a Rails install with a template based on PostgreSQL/HAML/Rspec, but the goal is to eventually allow anyone to specify their default template, or handpick a template on per-project basis.

## Usage

```
gem install rails
gem install primo

primo app_name #instead of "rails new app_name"
```

This generates PostgreSQL/HAML/Rspec Rails app using [this template](https://github.com/cbetta/primo/blob/master/templates/prime.rb).

## Plans

* Allow user to specify custom template (from gem, local, or remote) in a ~/.primo file
* Add more standard templates to the gem
* Think about a "template server" much like rubygems.org to allow people to upload/share their templates and reference them by name.

## Release notes

* **0.0.4** Fixing template
* **0.0.3** Removed direct Rails dependency
* **0.0.2** Added simple installer for "Prime stack"
* **0.0.1** Gem skeleton

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

See [LICENSE](https://github.com/cbetta/primo/blob/master/LICENSE)

