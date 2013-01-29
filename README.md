# Primo

A configurable default Rails stack.

This is a proof of concept and any feedback is welcome either on [GitHub](https://github.com/cbetta/primo/issues), [Twitter](http://twitter.com/cbetta), or [email](mailto:primo@cgb.im). 

Inspired by Steve Klabnik's article ["Rails has Two Default Stacks"](http://words.steveklabnik.com/rails-has-two-default-stacks) and the awesome [Rails application templates](http://edgeguides.rubyonrails.org/rails_application_templates.html#gem-args).

## Why is this useful?

Rails application templates are awesome, especially for hackers that often need to set up the same basic app, but also for companies that want to promote their best pratices. Sadly the ecosystem around them seems to be quite limited. Primo tries to solve this by adding a command line interface for defining your default template and share it with others.

At the moment Primo allows you to run a Rails install with a template based on PostgreSQL/HAML/Rspec. It also allows you to specify your own default template in a .primo file.

## What is next?

I have been thinking about a "template server" much like rubygems.org to allow people to upload/share their templates and reference them by name. I would love to know if this an idea worth exploring or just silly. [Join the discussion here](https://github.com/cbetta/primo/issues/2)

## Usage

### Basic

    gem install rails
    gem install primo

    primo new app_name #instead of "rails new app_name"

This generates a PostgreSQL/HAML/Rspec Rails app using [this admittedly very basic template](https://github.com/cbetta/primo/blob/master/templates/prime.rb).

Specify a different build in template (currently only 2) as follows

    primo new app_name -t template_name

### Specify default template

Using a different template is easy. You can specify them locally, remotely, or choose one of the [build in templates](https://github.com/cbetta/primo/blob/master/templates/) by name.

    primo default template_name                     # one of the provided templates
    primo default /local/path/to/template.rb        # a full path (or relative to home) to the template file
    primo default http://remote.path/to/template.rb # a url pointing to a template file

or edit `~/.primo`:

    default="template_name"
    default="/local/path/to/template.rb"
    default="http://remote.path/to/template.rb"
    
## Todos

* Add tests
* Look into template server idea

## Release notes

* **0.0.6** Allows for overriding of templates
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

