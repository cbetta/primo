# Primo

A configurable default Rails stack.

Inspired by Steve Klabnik's article ["Rails has Two Default Stacks"](http://words.steveklabnik.com/rails-has-two-default-stacks) and the awesome Rails application templates.

## Why is this useful?

Rails application templates are awesome, especially for hackers that often need to set up the same basic app. Sadly the ecosystem around them seems to be quite limited. Primo tries to solve this by adding a command line interface for defining your default template and share it with others.

At the moment Primo allows you to run a Rails install with a template based on PostgreSQL/HAML/Rspec, but the goal is to eventually allow anyone to specify their default template, or handpick a template on per-project basis.

## Usage

### Basic

    gem install rails
    gem install primo

    primo new app_name #instead of "rails new app_name"

This generates a PostgreSQL/HAML/Rspec Rails app using [this template](https://github.com/cbetta/primo/blob/master/templates/prime.rb).

### Specify default template

Using a different template is easy. You can specify them locally, remotely, or choose one of the [build in templates](https://github.com/cbetta/primo/blob/master/templates/) by name.

    primo default template_name                     # one of the provided templates
    primo default /local/path/to/template.rb        # a full path (or relative to home) to the template file
    primo default http://remote.path/to/template.rb # a url pointing to a template file

or edit `~/.primo`:

    default="template_name"
    default="/local/path/to/template.rb"
    default="http://remote.path/to/template.rb"

## Plans

* Allow user to specify custom template (from gem, local, or remote) in a ~/.primo file
* Add more standard templates to the gem
* Think about a "template server" much like rubygems.org to allow people to upload/share their templates and reference them by name.

## Release notes

* **0.0.5** Adds option to set custom default
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

